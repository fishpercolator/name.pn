import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['burger', 'menu']
  static classes = ['active']

  declare readonly burgerTarget: HTMLAnchorElement
  declare readonly menuTarget: HTMLElement
  declare activeClass: string

  public toggleMenu(): void {
    this.burgerTarget.classList.toggle(this.activeClass)
    this.menuTarget.classList.toggle(this.activeClass)
  }
}
