import { Controller } from "stimulus"
import Sortable from 'sortablejs'

export default class extends Controller {
  static targets = ['pronounless', 'list', 'option', 'position']

  connect () {
    this.changePronounless()
    this.fillPositions()
    this.sortable = Sortable.create(this.listTarget, {onUpdate: () => this.fillPositions()})
    this.positionTargets.forEach(t => t.style.display = 'none')
  }

  changePronounless() {
    let disabled = (this.pronounlessTarget.value !== '')
    this.optionTargets.forEach(t => t.disabled = disabled)
  }

  fillPositions() {
    let pos = 1
    this.positionTargets.forEach(t => t.value = pos++)
  }

  
}
