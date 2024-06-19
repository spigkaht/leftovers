import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
  }
  onScroll(event){
    if (window.scrollY < 100) {
      this.removeActiveClass()
    } else {
      this.addActiveClass()
    }
  }

  addActiveClass() {
    this.element.classList.add('active')
  }

  removeActiveClass() {
    this.element.classList.remove('active')
  }
}
