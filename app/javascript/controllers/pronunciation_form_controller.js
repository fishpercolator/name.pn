import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['output']
  
  changeChoice(e) {
    let chosen = e.currentTarget.options[e.currentTarget.selectedIndex].innerHTML
    this.outputTargets.forEach(t => t.innerHTML = chosen)
  }
}
