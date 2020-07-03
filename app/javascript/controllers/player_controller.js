import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['media', 'play']
  
  connect () {
    this.mediaTarget.addEventListener(
      'ended',
      () => { this.playTarget.disabled = false }
    )
  }
  
  play () {
    this.mediaTarget.play()
    this.playTarget.disabled = true
  }
}
