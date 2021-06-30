import { Controller } from "stimulus"

export default class extends Controller {
  close () {
    this.element.classList.remove('is-active')
  }
}
