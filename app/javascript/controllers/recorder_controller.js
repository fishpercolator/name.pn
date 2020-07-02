import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['player']
  
  async connect () {
    // Recorder is hidden in CSS - show it if we detect the browser supports it
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      try {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true })
        this.chunks = []
        this.recorder = new MediaRecorder(stream, { type: 'audio/webm' })
        this.recorder.addEventListener('dataavailable', e => this.newChunk(e))
        this.recorder.addEventListener('stop', () => this.saveRecording())
      } catch {
        console.log('Permission denied')
      }
      this.element.style.display = 'block'
    }
  }
  
  async start (e) {
    e.preventDefault()
    if (this.recorder.state === 'inactive') {
      this.chunks = []
      this.recorder.start()
    }
  }
  
  stop (e) {
    e.preventDefault()
    this.recorder.stop()
  }
  
  newChunk (e) {
    if (typeof e.data === 'undefined') return
    if (e.data.size === 0) return
    this.chunks.push(e.data)
    console.log(this.chunks)
  }
  
  saveRecording () {
    const recording = new Blob(this.chunks, { type: 'audio/webm' })
    const url = URL.createObjectURL(recording)
    this.playerTarget.setAttribute('src', url)
    this.playerTarget.setAttribute('controls', 'controls')
  }
}
