import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  static targets = ["container", "template"]

  connect() {
    super.connect()
    console.log("Stimulus connected")
  }

  addForm(event) {
    event.preventDefault()
    console.log("This is the addForm")
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.containerTarget.insertAdjacentHTML('beforeend', content)
  }

  removeForm(event) {
    event.preventDefault()
    let item = document.getElementById("nested-fields")
    // item.querySelector('input[name*="_destroy"]').value = "1"
    item.remove()
  }
}
