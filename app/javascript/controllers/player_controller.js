import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['media', 'play']
  static values = {
    url: String
  }
  
  connect () {
    this.mediaTarget.addEventListener('ended', () => { this.playTarget.disabled = false })
  }
  
  urlValueChanged () {
    let url = this.urlValue
    if (url) {
      this.mediaTarget.src = url
      this.playTarget.disabled = false
    } else {
      this.mediaTarget.removeAttribute('src')
      this.playTarget.disabled = true
    }
  }
  
  play () {
    this.mediaTarget.play()
    this.playTarget.disabled = true
  }
}
