import { Controller } from "stimulus"

import { RecordRTCPromisesHandler } from 'recordrtc'

export default class extends Controller {
  static targets = ['player', 'field', 'button']
  
  connect () {
    // Recorder is hidden in CSS - show it if we detect the browser supports it
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      this.element.style.display = 'block'
    }
  }
  
  // FIXME: Catch user holding record button for too long etc
  async start (e) {
    e.preventDefault()
    try {
      this.stream = await navigator.mediaDevices.getUserMedia({ audio: true })
      this.chunks = []
      this.recorder = new RecordRTCPromisesHandler(this.stream, { 
        type: 'audio',
        numberOfAudioChannels: 1
      })
      this.recorder.startRecording()
      this.buttonTarget.classList.add('is-active')
    } catch {
      console.log('Permission denied')
    }
  }
  
  async stop (e) {
    e.preventDefault()
    await this.recorder.stopRecording()
    this.stream.getTracks().forEach(t => t.stop())
    this.buttonTarget.classList.remove('is-active')
    const recording = await this.recorder.getBlob()
    const reader = new FileReader()
    reader.readAsDataURL(recording)
    reader.onload = () => {this.fieldTarget.value = reader.result}
    const url = URL.createObjectURL(recording)
    this.playerTarget.setAttribute('src', url)
    this.playerTarget.setAttribute('controls', 'controls')
    
    this.fieldTarget.value = recording
  }
}
