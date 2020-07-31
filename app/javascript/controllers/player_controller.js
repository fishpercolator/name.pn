import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['media', 'play']
  
  connect () {
    this.mediaTarget.addEventListener(
      'ended',
      () => { this.playTarget.disabled = false }
    )
    this.setupAudio()
  }
  
  setupAudio () {
    let url = this.data.get('url')
    if (url) {
      // FIXME: Make this the transcode
      this.mediaTarget.setAttribute('src', this.data.get('url'))
      this.playTarget.disabled = false
    }
  }
  
  play () {
    this.mediaTarget.play()
    this.playTarget.disabled = true
  }
}
