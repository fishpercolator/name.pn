import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['url', 'copyButton']
  
  connect () {
    if (this.urlTarget) {
      this.url = this.urlTarget.innerHTML
    }
  }
  
  copy () {
    navigator.permissions.query({name: 'clipboard-write'}).then(result => {
      if (result.state == "granted" || result.status == "prompt") {
        navigator.clipboard.writeText(this.url).then(() => {
          this.copyButtonTarget.classList.add('copy-button--copied', 'animate__animated', 'animate__bounceIn')
        })
      }
    })
  }
  
}
