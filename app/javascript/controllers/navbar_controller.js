import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['burger', 'menu']

  toggleMenu() {
    this.burgerTarget.classList.toggle('is-active')
    this.menuTarget.classList.toggle('is-active')
  }
}
