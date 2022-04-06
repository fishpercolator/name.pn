import { Controller } from "stimulus"

export default class extends Controller {
  close() {
    this.element.style.display = 'none'
  }
}
