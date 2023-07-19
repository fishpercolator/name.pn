import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['card']
  static values = {
    hash: String
  }

  connect () {
    this.hashChange()
  }
  hashChange () {
    this.hashValue = window.location.hash
  }
  hashValueChanged(value) {
    let cardToShow
    if (cardToShow = this.cardTargets.find(x => value === `#${x.id}`)) {
      this.showCard(cardToShow)
    } else {
      this.showAllCards()
    }
  }
  // Given a card, show only that card
  showCard(card) {
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
  showAllCards() {
    this.cardTargets.forEach(x => x.classList.remove('is-hidden', 'is-shown-alone'))
  }
}
