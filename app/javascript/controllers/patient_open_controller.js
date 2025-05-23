import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="patient-open"
export default class extends Controller {
  connect() {
  }

  show(e) {
    e.preventDefault();
    let appointment = document.getElementById("appointment_register_add_doctor");
    appointment.style.display = "flex"
  }

  old_show(e) {
    e.preventDefault();
    let appointment = document.getElementById("appointment_register_doctor");
    appointment.style.display = "block"
  }

  old_remove(e) {
    e.preventDefault();
    let appointment = document.getElementById("appointment_register_doctor");
    appointment.style.display = "none"
  }

  message(e) {
    e.preventDefault();
    console.log("Message is app")
    let message_app = document.getElementById("chat_app_doctor")
    message_app.style.display = "block"
  }
  messageRemove(e) {
    e.preventDefault();
    let message_app = document.getElementById("chat_app_doctor")
    message_app.style.display = "none"
  }
  submit() {
    this.remove()
  }

  removeAppointment(e) {
    e.preventDefault();
    this.remove()
  }
  
  remove() {
    let showappointment = document.getElementById("appointment_register_add_doctor");
    showappointment.style.display = "none"
  }
}
