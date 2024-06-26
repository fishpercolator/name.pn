import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['output']

  declare readonly outputTargets: HTMLElement[]

  public changeChoice(e: Event): void {
    const target = e.currentTarget as HTMLSelectElement
    let chosen = target.options[target.selectedIndex].innerHTML
    this.outputTargets.forEach(t => t.innerHTML = chosen)
  }
}
