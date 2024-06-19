import { Controller } from "@hotwired/stimulus"

export default class extends Controller<HTMLElement> {
  public close(): void {
    this.element.style.display = 'none'
  }
}
