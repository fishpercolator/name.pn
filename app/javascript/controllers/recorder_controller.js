import { Controller } from "stimulus"

import Recorder from 'opus-recorder'
import encoderPath from 'opus-recorder/dist/encoderWorker.min.js'

export default class extends Controller {
  static targets = [
    'field', 'button', 'player', 
    'delete', 'deleteFlag'
  ]
  
  connect () {    
    // Recorder is hidden in CSS - show it if we detect the browser supports it
    if (Recorder.isRecordingSupported()) {
      this.element.classList.add('recorder--enabled')
      
      this.recorder = new Recorder({
        encoderPath
      })
      this.recorder.onstart = () => { this.buttonTarget.classList.add('is-active') }
      this.recorder.onstop = () => { this.buttonTarget.classList.remove('is-active') }
      this.recorder.ondataavailable = (arrayBuffer) => { this.processNewAudioData(arrayBuffer) }
    }
  }
  
  // FIXME: Catch user holding record button for too long etc
  start (e) {
    e.preventDefault()
    try {
      this.recorder.start()
    } catch(e) {
      console.log('Error: ' + e.message)
    }
  }
  
  stop (e) {
    e.preventDefault()
    this.recorder.stop()
  }
  
  processNewAudioData (recording) {
    this.fieldTarget.value = this.dataUrl(recording)
    this.initializePlayer(recording)
    this.deleteFlagTarget.value = ''
  }
  
  delete () {
    this.deleteFlagTarget.value = '1'
    this.mediaTarget.removeAttribute('src')
    this.playTarget.disabled = true
    this.deleteTarget.disabled = true
  }
  
  // Get a dataURL for the given arrayBuffer
  dataUrl(buf) {
    return 'data:audio/webm;codecs=opus;base64,' + btoa(String.fromCharCode.apply(null, new Uint8Array(buf)))
  }
}
