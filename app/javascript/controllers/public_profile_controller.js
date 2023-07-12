import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['card']
  static values = {
    hash: String
  }

  connect () {
    this.hashValue = window.location.hash
  }
  hashChange () {
    this.hashValue = window.location.hash
  }
  hashValueChanged(value) {
    this.cardTargets.forEach(c => {
      if (this.hashValue === `#${c.id}` || this.hashValue === '') {
        c.style.display = 'block'
      } else {
        c.style.display = 'none'
      }
    })
  }
}
