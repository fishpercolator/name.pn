import { Controller } from "stimulus"

import { RecordRTCPromisesHandler } from 'recordrtc'

export default class extends Controller {
  static targets = ['media', 'field', 'button', 'play', 'delete', 'deleteFlag']
  
  connect () {
    this.recording = false
    
    // Recorder is hidden in CSS - show it if we detect the browser supports it
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      this.element.style.display = 'block'
    }
    // If there is audio attached, enable the play button
    if (this.mediaTarget.src) {
      this.playTarget.disabled = false
      this.deleteTarget.disabled = false
    }
  }
  
  // FIXME: Catch user holding record button for too long etc
  async start (e) {
    e.preventDefault()
    this.recording = true
    try {
      this.stream = await navigator.mediaDevices.getUserMedia({ audio: true })
      this.chunks = []
      this.recorder = new RecordRTCPromisesHandler(this.stream, { 
        type: 'audio',
        numberOfAudioChannels: 1
      })
      if (this.recording) {
        // Check to see if we haven't already fired a stop event!
        this.recorder.startRecording()
        this.buttonTarget.classList.add('is-active')
      } else {
        // Fire the stop event one more time to clear up anything we raced into existence
        this.stop()
      }
    } catch {
      console.log('Permission denied')
    }
  }
  
  async stop (e) {
    e.preventDefault()
    this.recording = false
    this.buttonTarget.classList.remove('is-active')
    if (this.stream) {
      this.stream.getTracks().forEach(t => t.stop())
    }
    if (this.recorder) {
      await this.recorder.stopRecording()
      const recording = await this.recorder.getBlob()
      const reader = new FileReader()
      reader.readAsDataURL(recording)
      reader.onload = () => {this.fieldTarget.value = reader.result}
      const url = URL.createObjectURL(recording)
      this.mediaTarget.setAttribute('src', url)
      this.playTarget.disabled = false
      this.deleteTarget.disabled = false
      this.deleteFlagTarget.value = ''
      this.fieldTarget.value = recording
    }
    this.recorder = null
    this.stream = null
  }
  
  play () {
    this.mediaTarget.play()
  }
  
  delete () {
    this.deleteFlagTarget.value = '1'
    this.mediaTarget.removeAttribute('src')
    this.playTarget.disabled = true
    this.deleteTarget.disabled = true
  }
}
