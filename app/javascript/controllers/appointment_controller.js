import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="appointment"
export default class extends Controller {
  static targets = ["content", "appointment"]

  connect() {
    console.log("Appointment controller connected");
  }

  add(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    const appointment = document.getElementById("hidden");
    if (appointment) {
      appointment.classList.remove("d-none");
      appointment.classList.add("d-flex");
    }
  }

  remove(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    this.removeAddappointment()
  }

  removeAddappointment(){
    let appointment = document.getElementById("hidden");
    appointment.classList.remove("d-flex");
    appointment.classList.add("d-none");
  }

  statusAppointment(e) {
    let status = document.getElementById("status");
    let value = e.target.value;
    let todayDate = new Date().toLocaleDateString();
    let todayDateTime = `${this.DateFormat(todayDate)}T${new Date().toLocaleTimeString("en-US", {
      hour12: false,
      hour: "numeric",
      minute: "numeric",
    })}`;
    if (value >= todayDateTime) {
      status.value = false;
    } else {
      status.value = true;
    }
  }

  DateFormat(date) {
    var d = new Date(date),
      month = "" + (d.getMonth() + 1),
      day = "" + d.getDate(),
      year = d.getFullYear();

    if (month.length < 2) month = "0" + month;
    if (day.length < 2) day = "0" + day;

    return [year, month, day].join("-");
  }

  submit(e) {
    this.removeAddappointment()
  }

  showappointment(e){
    e.preventDefault();
    let showappointment = document.getElementById("hidden_appointment");
    showappointment.classList.remove("d-none")
    showappointment.classList.add("d-block")
  }
  
  removeAppointment(e){
    e.preventDefault();
    let showappointment = document.getElementById("hidden_appointment");
    showappointment.classList.add("d-none")
    showappointment.classList.remove("d-block")
  }
}
