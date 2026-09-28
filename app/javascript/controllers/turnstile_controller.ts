/// <reference types="cloudflare-turnstile" />
import { Controller } from "@hotwired/stimulus"

const SCRIPT_URL = "https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit"

let scriptLoaded: Promise<void> | undefined

function loadScript () {
  scriptLoaded ??= new Promise((resolve, reject) => {
    const script = document.createElement("script")
    script.src = SCRIPT_URL
    script.onload = () => resolve()
    script.onerror = reject
    document.head.append(script)
  })
  return scriptLoaded
}

export default class extends Controller<HTMLElement> {
  override async connect () {
    await loadScript()
    turnstile.render(this.element)
  }

  override async disconnect () {
    await loadScript()
    turnstile.remove(this.element)
  }
}
