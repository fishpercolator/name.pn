import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['option']

  changePronounless(e) {
    let disabled = (e.target.value !== '')
    this.optionTargets.forEach(t => t.disabled = disabled)
  }
}
