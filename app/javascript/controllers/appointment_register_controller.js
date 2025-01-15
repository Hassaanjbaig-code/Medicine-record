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
    let appointment = document.getElementById("appointment_register_1");
    appointment.style.display = "none"
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
