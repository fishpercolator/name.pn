import { Controller } from "@hotwired/stimulus"

import { Luminous } from 'luminous-lightbox'

export default class extends Controller {
  connect () {
    this.lightbox = new Luminous(this.element)
  }
}
