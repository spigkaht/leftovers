import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favourites"
export default class extends Controller {
  static targets = ["recipe"]
  connect() {
    console.log("hi from fav controller")
  }
  createFavourite() {
    console.log("ive been triggered")
  }
}
