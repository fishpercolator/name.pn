import { Controller } from "@hotwired/stimulus"

import { Uppload, Local, Camera, Crop, Rotate, Brightness, Contrast, xhrUploader, en } from "uppload";
import Rails from '@rails/ujs'

export default class extends Controller {
  static targets = ['preview', 'delete']
  
  connect() {
    this.uploader = new Uppload({
      lang: en,
      defaultService: 'local',
      compression: 0.8,
      maxSize: [1024, 1024],
      uploader: xhrUploader({
        endpoint: '/profile/likeness',
        fileKeyName: 'user[likeness]',
        method: 'PATCH',
        settingsFunction: xmlHttp => {
          xmlHttp.setRequestHeader('Accept', 'application/json')
          xmlHttp.setRequestHeader('X-CSRF-Token', Rails.csrfToken())
        }
      })
    })
    this.uploader.use([
      new Local(),
      new Camera(),
      new Crop({
        aspectRatio: 1
      }),
      new Rotate(),
      new Brightness(),
      new Contrast()
    ])
    this.uploader.on('upload', url => {
      let img = document.createElement('img')
      img.setAttribute('src', url)
      this.previewTarget.innerHTML = ''
      this.previewTarget.appendChild(img)
      this.deleteTarget.disabled = false
    })
  }
  
  start() {
    this.uploader.open()
  }
  
}
