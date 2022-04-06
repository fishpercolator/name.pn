import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['burger', 'menu']
  static classes = ['active']

  toggleMenu() {
    this.burgerTarget.classList.toggle(this.activeClass)
    this.menuTarget.classList.toggle(this.activeClass)
  }
}
