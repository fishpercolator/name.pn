import { Controller } from "@hotwired/stimulus"
import * as emr from 'extendable-media-recorder';
import * as wav from 'extendable-media-recorder-wav-encoder';

export default class extends Controller {
  static targets = ['field', 'button', 'player', 'delete', 'deleteFlag']
  
  static classes = [
    'granted', 'prompt', 'denied'
  ]

  async connect () {
    this.activated = false
    await emr.register(await wav.connect())
    this.testMicState()
    this.testDeleteState()
  }

  // Test the current state of the mic and set classes on the element accordingly
  async testMicState() {
    this.micState = await navigator.permissions.query({ name: 'microphone' })

    // Remove any classes that were added by earlier calls to this method
    this.element.classList.remove(this.grantedClass, this.promptClass, this.deniedClass)
    // Set the appropriate class for the current micState
    if (this.micState.state) {
      this.element.classList.add(this[this.micState.state + 'Class'])
    }
  }

  // Ask for the user's permission to stream and stop the stream immediately after
  async prompt () {
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
  testDeleteState() {
    this.deleteTarget.disabled = !this.playerTarget.dataset['playerUrlValue']
  }

  // Event fires when the uploaded file changes
  recorded (e) {
    const file = e.target.files[0]
    const url = URL.createObjectURL(file)
    this.setPlayerUrl(url)
  }

  async start () {
    this.activated = true
    this.buttonTarget.classList.add('is-waiting')
    this.stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: false })
    const recordedChunks = []
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

  stop () {
    this.activated = false
    this.buttonTarget.classList.remove('is-waiting', 'is-active')
    if (this.mr && this.mr.state !== 'inactive') {
      this.mr.stop()
      this.mr = null
    }
    if (this.stream) {
      this.stream.getTracks().forEach(t => t.stop())
      this.stream = null
    }
  }
  
  delete () {
    this.deleteFlagTarget.value = '1'
    this.fieldTarget.value = null
    this.setPlayerUrl(null)
  }
  
  setPlayerUrl (url) {
    if (url === null) {
      delete this.playerTarget.dataset.playerUrlValue
    } else {
      this.playerTarget.dataset.playerUrlValue = url
    }
    this.testDeleteState()
  }
}
