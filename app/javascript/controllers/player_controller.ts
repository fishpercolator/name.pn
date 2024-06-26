import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['media', 'play']
  static values = {
    url: String
  }

  declare readonly mediaTarget: HTMLAudioElement
  declare readonly playTarget: HTMLButtonElement
  declare urlValue: string

  override connect () {
    this.mediaTarget.addEventListener('ended', () => { this.playTarget.disabled = false })
  }

  protected urlValueChanged (): void {
    let url = this.urlValue
    if (url) {
      this.mediaTarget.src = url
      this.playTarget.disabled = false
    } else {
      this.mediaTarget.removeAttribute('src')
      this.playTarget.disabled = true
    }
  }

  public play (): void {
    this.mediaTarget.play()
    this.playTarget.disabled = true
  }
}
