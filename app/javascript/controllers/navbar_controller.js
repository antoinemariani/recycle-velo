import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = []

  connect() {
    console.log('hello from stimulus!');
  }

  updateNavbar() {
    if (window.location.pathname === "/") {
      this.element.classList.add("navbar-lewagon-transparent")
      if (window.scrollY > 380 ) {
        this.element.classList.remove("navbar-lewagon-transparent")
      }
    }
  }
}
