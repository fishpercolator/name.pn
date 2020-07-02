import { Controller } from "stimulus"

import fitty from 'fitty'

export default class extends Controller {
  static targets = ['fit']
  
  connect() {
    this.fitTargets.forEach(el => fitty(el, {maxSize: 120}))
  }
}
