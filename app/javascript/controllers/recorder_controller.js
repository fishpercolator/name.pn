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
        encoderPath,
        encoderApplication: 2048,
        encoderSampleRate: 48000,
        encoderComplexity: 8,
        streamPages: false
      })
      this.recorder.onstart = () => { this.buttonTarget.classList.add('is-active') }
      this.recorder.onstop = () => { this.buttonTarget.classList.remove('is-active') }
      this.recorder.ondataavailable = (arrayBuffer) => { this.processNewAudioData(arrayBuffer) }
      
      if (this.playerTarget.dataset['playerUrl']) {
        this.deleteTarget.disabled = false
      }
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
    const rec_blob = new Blob([recording])
    const rec_url = URL.createObjectURL(rec_blob)
    this.setPlayerUrl(rec_url)
    this.deleteFlagTarget.value = ''
  }
  
  delete () {
    this.deleteFlagTarget.value = '1'
    this.deleteTarget.disabled = true
    this.setPlayerUrl(null)
  }
  
  setPlayerUrl (url) {
    if (url === null) {
      delete this.playerTarget.dataset.playerUrl
    } else {
      this.playerTarget.dataset.playerUrl = url
    }
    const event = new CustomEvent('new-url')
    this.playerTarget.dispatchEvent(event)
  }
  
  // Get a dataURL for the given arrayBuffer
  dataUrl(buf) {
    return 'data:audio/ogg;codecs=opus;base64,' + btoa(String.fromCharCode.apply(null, new Uint8Array(buf)))
  }
}
