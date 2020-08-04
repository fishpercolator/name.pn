import { Controller } from "stimulus"

let ogv = require('ogv')
ogv.OGVLoader.base = '/ogv'

export default class extends Controller {
  static targets = ['media', 'play']
  
  connect () {
    this.element.addEventListener('new-url', () => { this.refresh() })
    this.player = new ogv.OGVPlayer()
    this.player.addEventListener('ended', () => { this.playTarget.disabled = false })
    this.mediaTarget.appendChild(this.player)
    this.refresh()
  }
  
  refresh () {
    let url = this.data.get('url')
    if (url) {
      this.player.src = url
      this.playTarget.disabled = false
    } else {
      this.player.removeAttribute('src')
      this.playTarget.disabled = true
    }
  }
  
  play () {
    this.player.play()
    this.playTarget.disabled = true
  }
}
