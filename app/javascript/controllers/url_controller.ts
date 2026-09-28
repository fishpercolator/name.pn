import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['url', 'swap']
  static classes = ['copied']

  declare readonly urlTarget: HTMLElement
  declare readonly swapTarget: HTMLElement
  declare readonly copiedClass: string

  url: string = ''

  override connect () {
    this.url = this.urlTarget.innerHTML
  }

  public async copy (): Promise<void> {
    await navigator.clipboard.writeText(this.url)
    this.swapTarget.classList.add(this.copiedClass)
  }
}
