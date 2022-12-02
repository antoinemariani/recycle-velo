import { Controller } from "@hotwired/stimulus"
import { Popover } from "bootstrap/dist/js/bootstrap.bundle.js";

// Connects to data-controller="popover"
export default class extends Controller {
  connect() {
    new Popover(this.element)
    console.log("popover")
  }
}
