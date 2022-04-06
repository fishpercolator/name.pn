import { Controller } from "stimulus"

import fitty from 'fitty'

export default class extends Controller {
  static targets = ['fit']
  
  connect() {
    this.fitTargets.forEach(el => {
      const maxSize = parseInt(el.dataset.maxSize) || 48
      fitty(el, {maxSize})
    })
  }
}
