import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['url', 'copyButton']
  static classes = ['copied']

  declare readonly urlTarget: HTMLElement
  declare readonly copyButtonTarget: HTMLButtonElement
  declare readonly copiedClass: string

  url: string = ''

  override connect () {
    this.url = this.urlTarget.innerHTML
  }

  public async copy (): Promise<void> {
    await navigator.clipboard.writeText(this.url)
    this.copyButtonTarget.classList.add(this.copiedClass, 'animate-bounce-in')
  }
}
