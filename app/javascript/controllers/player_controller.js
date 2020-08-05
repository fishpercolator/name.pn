import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['media', 'play']
  
  connect () {
    this.element.addEventListener('new-url', () => { this.refresh() })
    this.mediaTarget.addEventListener('ended', () => { this.playTarget.disabled = false })
    this.refresh()
  }
  
  refresh () {
    let url = this.data.get('url')
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
