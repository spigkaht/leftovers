import { Controller } from "@hotwired/stimulus"
import ScrollTo from 'stimulus-scroll-to'

// Connects to data-controller="scroll-to"
export default class extends ScrollTo {
  connect() {
    super.connect()
    console.log('Do what you want here.')
  }

  // You can set default options in this getter for all your anchors.
  get defaultOptions() {
    return {
      offset: 100,
      behavior: 'auto',
    }
  }
}
