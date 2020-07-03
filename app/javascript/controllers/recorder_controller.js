import { Controller } from "stimulus"

import { RecordRTCPromisesHandler } from 'recordrtc'

export default class extends Controller {
  static targets = ['player']
  
  async connect () {
    // Recorder is hidden in CSS - show it if we detect the browser supports it
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      try {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true })
        this.chunks = []
        this.recorder = new RecordRTCPromisesHandler(stream, { type: 'audio' })
      } catch {
        console.log('Permission denied')
      }
      this.element.style.display = 'block'
    }
  }
  
  start (e) {
    e.preventDefault()
    this.recorder.startRecording()
  }
  
  async stop (e) {
    e.preventDefault()
    await this.recorder.stopRecording()
    const recording = await this.recorder.getBlob()
    const url = URL.createObjectURL(recording)
    this.playerTarget.setAttribute('src', url)
    this.playerTarget.setAttribute('controls', 'controls')
  }
}
