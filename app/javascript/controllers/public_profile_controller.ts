import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['card']
  static values = {
    hash: String
  }

  declare hashValue: string
  declare readonly cardTargets: HTMLDivElement[]

  override connect() {
    this.hashChange()
  }

  public hashChange(): void {
    this.hashValue = window.location.hash
  }

  protected hashValueChanged(value: string): void {
    let cardToShow
    if (cardToShow = this.cardTargets.find(x => value === `#${x.id}`)) {
      this.showCard(cardToShow)
    } else {
      this.showAllCards()
    }
  }
  // Given a card, show only that card
  protected showCard(card: HTMLDivElement): void {
    this.cardTargets.forEach(x => {
      if (x === card) {
        x.classList.remove('is-hidden')
        x.classList.add('is-shown-alone')
      } else {
        x.classList.add('is-hidden')
        x.classList.remove('is-shown-alone')
      }
    })
  }
  // Show all cards
  protected showAllCards(): void {
    this.cardTargets.forEach(x => x.classList.remove('is-hidden', 'is-shown-alone'))
  }
}
