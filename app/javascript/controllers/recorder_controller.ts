import { Controller } from "@hotwired/stimulus"
import * as emr from 'extendable-media-recorder';
import * as wav from 'extendable-media-recorder-wav-encoder';

export default class RecorderController extends Controller {
  static targets = ['field', 'button', 'player', 'delete', 'deleteFlag']

  static classes = [
    'granted', 'prompt', 'denied'
  ]

  static values = {
    mockPermission: String
  }

  declare readonly fieldTarget: HTMLInputElement // type="file"
  declare readonly buttonTarget: HTMLButtonElement
  declare readonly playerTarget: HTMLDivElement
  declare readonly deleteTarget: HTMLButtonElement
  declare readonly deleteFlagTarget: HTMLInputElement // type="checkbox"

  declare readonly grantedClass: string
  declare readonly promptClass: string
  declare readonly deniedClass: string

  declare mockPermissionValue: string

  mr?: emr.IMediaRecorder
  stream?: MediaStream
  activated: boolean = false
  micState: PermissionStatus = <PermissionStatus>{
    name: 'microphone',
    state: 'denied'
  }

  override async connect (): Promise<void> {
    await this.registerWav()
    this.testMicState()
    this.testDeleteState()
  }

  // Register the wav encoder if it's not already been registered
  private async registerWav(): Promise<void> {
    try {
      await emr.register(await wav.connect())
    } catch (err) {
      // We might have already stored the encoder (thanks Turbolinks!) - if that's the case
      // we can safely ignore this exception. Otherwise, re-throw
      if (!(err instanceof Error && err.message.match(/already an encoder stored/))) throw err
    }
  }

  // Test the current state of the mic and set classes on the element accordingly
  private async testMicState(): Promise<void> {
    if (this.mockPermissionValue) {
      this.micState = <PermissionStatus>{
        name: 'microphone',
        state: this.mockPermissionValue
      }
    } else {
      this.micState = await navigator.permissions.query({ name: 'microphone' as PermissionName })
    }

    // Remove any classes that were added by earlier calls to this method
    this.element.classList.remove(this.grantedClass, this.promptClass, this.deniedClass)
    // Set the appropriate class for the current micState
    if (this.micState.state) {
      const className = (this.micState.state + 'Class') as "grantedClass"|"promptClass"|"deniedClass"
      this.element.classList.add(this[className])
    }
  }

  // Ask for the user's permission to stream and stop the stream immediately after
  public async prompt (): Promise<void> {
    try {
      this.stream = await navigator.mediaDevices.getUserMedia({audio: true, video: false})
      this.stop()
    } catch (e) {
      // Just log errors
      console.error(e)
    } finally {
      this.testMicState()
    }
  }

  // Activate the delete button if there's something in the player
  private testDeleteState(): void {
    this.deleteTarget.disabled = !this.playerTarget.dataset['playerUrlValue']
  }

  // Event fires when the uploaded file changes
  public recorded (e: Event) {
    const input = e.target as HTMLInputElement
    if (input.files) {
      const file = input.files[0]
      const url = URL.createObjectURL(file)
      this.setPlayerUrl(url)
    }
  }

  public async start (): Promise<void> {
    this.activated = true
    this.buttonTarget.classList.add('is-waiting')
    this.stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: false })
    const recordedChunks: BlobPart[] = []
    const mimeType = 'audio/wav'
    this.mr = new emr.MediaRecorder(this.stream, { mimeType })
    this.mr.addEventListener('start', () => {
      // If the user deactivated before we got here, just run the stop routine again
      if (this.activated) {
        this.buttonTarget.classList.remove('is-waiting')
        this.buttonTarget.classList.add('is-active')
      } else {
        this.stop()
      }
    })
    this.mr.addEventListener('dataavailable', e => { if (e.data.size > 0) recordedChunks.push(e.data) })
    this.mr.addEventListener('stop', () => {
      const url = URL.createObjectURL(new Blob(recordedChunks, { type: mimeType }))
      this.setPlayerUrl(url)
      const file = new File(recordedChunks, `pronunciation.wav`, { type: mimeType })
      const container = new DataTransfer()
      container.items.add(file)
      this.fieldTarget.files = container.files
    })
    this.mr.start()
  }

  public stop (): void {
    this.activated = false
    this.buttonTarget.classList.remove('is-waiting', 'is-active')
    if (this.mr && this.mr.state !== 'inactive') {
      this.mr.stop()
      this.mr = undefined
    }
    if (this.stream) {
      this.stream.getTracks().forEach(t => t.stop())
      this.stream = undefined
    }
  }

  public delete (): void {
    this.deleteFlagTarget.checked = true
    this.fieldTarget.value = ''
    this.setPlayerUrl(null)
  }

  private setPlayerUrl (url: string | null): void {
    if (url) {
      this.playerTarget.dataset.playerUrlValue = url
    } else {
      delete this.playerTarget.dataset.playerUrlValue
    }
    this.testDeleteState()
  }
}
