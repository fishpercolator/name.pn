import { BasePlugin } from "@uppy/core";

declare module "luminous-lightbox" {
  export class Luminous {
    constructor(trigger: HTMLElement, options = {})
  }
}
