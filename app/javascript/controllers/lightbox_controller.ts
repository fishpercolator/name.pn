import { Controller } from "@hotwired/stimulus"

import { Luminous } from 'luminous-lightbox'

export default class extends Controller<HTMLElement> {
  lightbox?: Luminous

  override connect () {
    this.lightbox = new Luminous(this.element)
  }
}
