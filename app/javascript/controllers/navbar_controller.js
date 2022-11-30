import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = []

  connect() {
    console.log('hello from stimulus!');
  }

  updateNavbar() {
    if (window.location.pathname === "/") {
      if (window.scrollY <= (0.5 * window.innerHeight)) {
        this.element.classList.add("navbar-lewagon-transparent")
      } else {
        this.element.classList.remove("navbar-lewagon-transparent")
      }
    }
  }
}
