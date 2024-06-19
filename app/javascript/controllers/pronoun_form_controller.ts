import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs'

export default class extends Controller {
  static targets = ['pronounless', 'list', 'option', 'position', 'handle']

  sortable?: Sortable
  declare readonly listTarget: HTMLElement
  declare readonly positionTargets: HTMLInputElement[]
  declare readonly optionTargets: HTMLInputElement[]
  declare readonly handleTargets: HTMLElement[]
  declare readonly pronounlessTarget: HTMLSelectElement

  connect () {
    this.changePronounless()
    this.fillPositions()
    this.sortable = Sortable.create(this.listTarget, {
      filter: 'input[type="checkbox"]',
      forceFallback: true,
      onUpdate: () => this.fillPositions()
    })
    this.positionTargets.forEach(t => t.style.display = 'none')
    this.handleTargets.forEach(t => t.style.display = 'inline')
  }

  protected changePronounless(): void {
    let disabled = (this.pronounlessTarget.value !== '')
    this.optionTargets.forEach(t => t.disabled = disabled)
  }

  protected fillPositions(): void {
    let pos = 1
    this.positionTargets.forEach(t => t.value = (pos++).toString())
  }
}
