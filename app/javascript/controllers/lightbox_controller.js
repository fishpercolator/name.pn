import { Controller } from "stimulus"

import { Luminous } from 'luminous-lightbox'

export default class extends Controller {
  connect () {
    this.lightbox = new Luminous(this.element, {
      injectBaseStyles: false
    })
  }
}
