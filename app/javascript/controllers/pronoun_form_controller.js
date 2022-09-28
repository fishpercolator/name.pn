import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['pronounless', 'option']

  connect () {
    this.changePronounless()
  }

  changePronounless() {
    let disabled = (this.pronounlessTarget.value !== '')
    this.optionTargets.forEach(t => t.disabled = disabled)
  }
}
