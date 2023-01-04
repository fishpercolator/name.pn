import { Controller } from "@hotwired/stimulus"

// import Recorder from 'opus-recorder'

export default class extends Controller {
  static targets = ['field', 'button', 'player', 'delete', 'deleteFlag']
  
  static classes = [
    'granted', 'prompt', 'denied'
  ]

  connect () {
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

  stop () {
    if (this.stream) {
      this.stream.getTracks().forEach(t => t.stop())
      this.stream = null
    }
  }
  
  // connect () {    
  //   // Recorder is hidden in CSS - show it if we detect the browser supports it
  //   if (Recorder.isRecordingSupported()) {
  //     this.element.classList.add(this.enabledClass)
      
  //     this.initializeRecorder()
  //     this.initializeFileReader()
      
  //     if (this.playerTarget.dataset['playerUrlValue']) {
  //       this.deleteTarget.disabled = false
  //     }
  //   }
  // }
  
  // initializeRecorder () {
  //   this.recorder = new Recorder({
  //     encoderPath: '/workers/waveWorker.min.js',
  //     streamPages: false,
  //     numberOfChannels: 1,
  //     wavBitDepth: 16
  //   })
  //   this.recorder.onstart = () => { this.buttonTarget.classList.add('is-active') }
  //   this.recorder.onstop = () => { this.buttonTarget.classList.remove('is-active') }
  //   this.recorder.ondataavailable = (arrayBuffer) => { this.processNewAudioData(arrayBuffer) }
  // }
  
  // initializeFileReader () {
  //   this.reader = new FileReader ()
  //   this.reader.onload = (e) => {
  //     this.fieldTarget.value = this.reader.result
  //   }
  // }
  
  // // FIXME: Catch user holding record button for too long etc
  // start (e) {
  //   e.preventDefault()
  //   try {
  //     this.recorder.start()
  //   } catch(e) {
  //     console.log('Error: ' + e.message)
  //   }
  // }
  
  // stop (e) {
  //   e.preventDefault()
  //   this.recorder.stop()
  // }
  
  // processNewAudioData (recording) {
  //   const rec_blob = new Blob([recording])
    
  //   // This sets the file for upload
  //   this.reader.readAsDataURL(rec_blob)
    
  //   // This uses a blob locally for the preview player
  //   const rec_url = URL.createObjectURL(rec_blob)
  //   this.setPlayerUrl(rec_url)
    
  //   // And finally, make sure the delete button is active
  //   this.deleteFlagTarget.value = ''
  //   this.deleteTarget.disabled = false
  // }
  
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
  
  // // Get a dataURL for the given arrayBuffer
  // dataUrl(buf) {
  //   return 'data:audio/ogg;codecs=opus;base64,' + btoa(String.fromCharCode.apply(null, new Uint8Array(buf)))
  // }
}
