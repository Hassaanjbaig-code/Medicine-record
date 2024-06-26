import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="time-zone"
export default class extends Controller {
  static targets = ["select", "button"]

  connect() {
    // Ensures proper connection of the controller
    super.connect()
    console.log("Time zone")
    
    // If no value is selected, set it to the system's time zone
    if (!this.selectTarget.value) {
      this.selectTarget.value = this.#systemTimeZone
    }
    // Hide the button if the system time zone is already selected
    this.hideButtonIfSystemTimeZoneSet()
  }

  // Private method to get the system's time zone
  get #systemTimeZone() {
    return Intl.DateTimeFormat().resolvedOptions().timeZone
  }

  // Method to set the select value to the system's time zone
  appleSystemTimeZone() {
    this.selectTarget.value = this.#systemTimeZone
    this.hideButtonIfSystemTimeZoneSet()
  }

  // Method to hide the button if the system time zone is set
  hideButtonIfSystemTimeZoneSet() {
    const shouldHide = this.selectTarget.value === this.#systemTimeZone
    // Correctly toggle the "hidden" class based on shouldHide
    // this.buttonTarget.classList.toggle("hidden", shouldHide)
    if (shouldHide) {
      this.buttonTarget.style.display = "none"
    }
    else {
      this.buttonTarget.style.display = "block"
    }
  }
}
