import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navtabs"
export default class extends Controller {
  static targets = ["tab1", "tab2", "tab3", "bikes", "shops", "recyclers"]

  connect() {
  }

  displayBike() {
    this.tab1Target.classList.add("tab-active")
    this.bikesTarget.classList.remove("d-none")

    this.tab2Target.classList.remove("tab-active")
    this.shopsTarget.classList.add("d-none")
    this.tab3Target.classList.remove("tab-active")
    this.recyclersTarget.classList.add("d-none")
  }

  displayShop(){
    this.tab2Target.classList.add("tab-active")
    this.shopsTarget.classList.remove("d-none")

    this.tab1Target.classList.remove("tab-active")
    this.bikesTarget.classList.add("d-none")
    this.tab3Target.classList.remove("tab-active")
    this.recyclersTarget.classList.add("d-none")
  }

  displayRecycler(){
    this.tab3Target.classList.add("tab-active")
    this.recyclersTarget.classList.remove("d-none")

    this.tab2Target.classList.remove("tab-active")
    this.shopsTarget.classList.add("d-none")
    this.tab1Target.classList.remove("tab-active")
    this.bikesTarget.classList.add("d-none")
  }
}
