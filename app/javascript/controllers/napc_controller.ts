import { Controller } from "@hotwired/stimulus"

import fitty from 'fitty'

export default class extends Controller {
  static targets = ['fit']

  declare readonly fitTargets: HTMLElement[]

  override connect() {
    this.fitTargets.forEach(el => {
      const maxSize = parseInt(el.dataset.maxSize ?? "48")
      fitty(el, {maxSize})
    })
  }
}
