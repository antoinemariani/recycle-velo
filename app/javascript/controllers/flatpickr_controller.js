import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  // Inform the controller that it has two targets in the form, which are our inputs
  static targets = [ "startTime", "endTime" ]

  connect() {
    console.log('connect function = connected')
    flatpickr(this.startTimeTarget, {
      enableTime: true,
      minuteIncrement: 30,
      time_24hr: true
    });
    flatpickr(this.endTimeTarget, {
      enableTime: true,
      minuteIncrement: 30,
      time_24hr: true
    });
  }

  // update() {
  //   console.log('update function = connected')
  //   const newHour = parseInt(this.startTimeTarget.value.substr(-4,1), 10) + 1
  //   this.endTimeTarget.value = `${this.startTimeTarget.value.slice(0, -4)}${newHour}:00`
  // }

}
