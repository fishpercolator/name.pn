import { Controller } from "stimulus"
import Sortable from 'sortablejs'

export default class extends Controller {
  static targets = ['pronounless', 'list', 'option']

  connect () {
    this.sortable = Sortable.create(this.listTarget)
    this.changePronounless()
  }

  changePronounless() {
    let disabled = (this.pronounlessTarget.value !== '')
    this.optionTargets.forEach(t => t.disabled = disabled)
  }
}
