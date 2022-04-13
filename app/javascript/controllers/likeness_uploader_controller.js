import { Controller } from "stimulus"

import Uppy from '@uppy/core'
import XHRUpload from '@uppy/xhr-upload'
import Dashboard from '@uppy/dashboard'
import ImageEditor from '@uppy/image-editor'
import Rails from 'rails-ujs'

export default class extends Controller {
  static targets = ['preview', 'delete']
  
  connect() {
    this.uploader = new Uppy({
      restrictions: {
        maxNumberOfFiles: 1
      }
    })
    .use(Dashboard, {
      autoOpenFileEditor: true,
      showSelectedFiles: false
    })
    .use(ImageEditor, {
      target: Dashboard,
      quality: 0.8,
      cropperOptions: {
        aspectRatio: 1
      },
      actions: {
        revert: false,
        granularRotate: false,
        flip: false,
        cropSquare: false,
        cropWidescreen: false,
        cropWidescreenVertical: false
      }
    })
    .use(XHRUpload, {
      endpoint: '/profile/likeness',
      method: 'patch',
      fieldName: 'user[likeness]',
      headers: {
        accept: 'application/json',
        'x-csrf-token': Rails.csrfToken()
      }
    })
    this.uploader.on('file-editor:complete', () => {
      this.uploader.upload()
    })
    this.uploader.on('complete', result => {
      if (result.successful.length > 0) {
        let img = document.createElement('img')
        img.setAttribute('src', result.successful[0].uploadURL)
        this.previewTarget.innerHTML = ''
        this.previewTarget.appendChild(img)
        this.deleteTarget.disabled = false
        this.uploader.getPlugin('Dashboard').closeModal()
      }
    })
  }
  
  start() {
    this.uploader.reset()
    this.uploader.getPlugin('Dashboard').openModal()
  }
  
}
