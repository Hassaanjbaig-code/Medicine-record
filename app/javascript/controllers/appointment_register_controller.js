import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="appointment-register"
export default class extends Controller {
  static targets = ["content", "appointment"]
  connect() {
    console.log("Appointment is working")
  }

  show(e) {
    e.preventDefault();
    let appointment = document.getElementById("appointment_register");
    appointment.style.display = "flex"
  }

  old_show(e) {
    e.preventDefault();
    let appointment = document.getElementById("appointment_register_1");
    appointment.style.display = "block"
  }

  old_remove(e) {
    e.preventDefault();
    let appointment = document.getElementById("chat_app");
    appointment.style.display = "none"
  }

  old_appointmentClose(e) {
    e.preventDefault();
    // conosle.log("This is the close of the appointment register")
    let appointment = document.getElementById("appointment_register_1");
    appointment.style.display = "none"
  }

  messageApp(e) {
    e.preventDefault();
    console.log("Message is app")
    let message_app = document.getElementById("chat_app")
    message_app.style.display = "block"
  }

  submit() {
    this.remove()
  }

  removeAppointment(e) {
    e.preventDefault();
    this.remove()
  }

  remove() {
    let showappointment = document.getElementById("appointment_register");
    showappointment.style.display = "none"
  }
}
