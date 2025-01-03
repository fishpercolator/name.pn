import { Controller } from "@hotwired/stimulus"

import Uppy, { Meta } from '@uppy/core'
import XHRUpload from '@uppy/xhr-upload'
import Dashboard from '@uppy/dashboard'
import ImageEditor from '@uppy/image-editor'
import Webcam from '@uppy/webcam'
import Rails from '@rails/ujs'

export default class extends Controller {
  static targets = ['preview', 'delete']

  static values = {
    endpoint: { type: String, default: '/profile/likeness' },
    fieldName: { type: String, default: 'user[likeness]' }
  }

  declare readonly previewTarget: HTMLDivElement
  declare readonly deleteTarget: HTMLButtonElement
  declare readonly endpointValue: string
  declare readonly fieldNameValue: string

  readonly uploader = new Uppy({
    restrictions: {
      maxNumberOfFiles: 1,
      maxFileSize: 1048576,
      allowedFileTypes: ['image/jpeg', 'image/png', 'image/gif']
    }
  })

  override connect(): void {
    this.uploader
    .use(Dashboard, {
      autoOpen: 'imageEditor'
    })
    .use(Webcam, {
      modes: ['picture']
    })
    .use(ImageEditor, {
      quality: 0.8,
      cropperOptions: {
        aspectRatio: 1,
        croppedCanvasOptions: {},
      },
      actions: {
        revert: false,
        rotate: true,
        granularRotate: false,
        flip: false,
        zoomIn: true,
        zoomOut: true,
        cropSquare: false,
        cropWidescreen: false,
        cropWidescreenVertical: false
      }
    })
    .use(XHRUpload, {
      endpoint: this.endpointValue,
      method: 'PATCH',
      fieldName: this.fieldNameValue,
      headers: {
        accept: 'application/json',
        'x-csrf-token': Rails.csrfToken() ?? ''
      }
    })
    this.uploader.on('file-editor:complete', () => {
      this.uploader.upload()
    })
    this.uploader.on('file-editor:cancel', () => {
      this.uploader.cancelAll()
    })
    this.uploader.on('complete', result => {
      if (result.successful && result.successful.length > 0) {
        let img = document.createElement('img')
        img.setAttribute('src', result.successful[0].uploadURL ?? '')
        this.previewTarget.innerHTML = ''
        this.previewTarget.appendChild(img)
        this.deleteTarget.disabled = false;
        // FIXME: Should have a stricter type than 'any'
        (this.uploader.getPlugin('Dashboard') as any).closeModal()
        this.uploader.cancelAll()
      }
    })
  }
  
  public start(): void {
    (this.uploader.getPlugin('Dashboard') as any).openModal()
  }
  
}
