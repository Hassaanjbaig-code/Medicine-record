import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message-push"
export default class extends Controller {
  connect() {
    console.log("It is connected with the message app")
  }

  showMessage(event) {
    event.preventDefault(); // Prevent link default behavior
    const userId = event.currentTarget.dataset.userId;
    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content"); // Get CSRF token

    // Make an AJAX call to fetch the message
    fetch(`/doctor_appointment/${userId}/show_message`, {
      method: "GET",
      headers: {
        Accept: "text/javascript",
        "X-CSRF-Token": csrfToken  // Add CSRF token to the request headers
      }
    }).then((response) => {
      if (response.ok) {
        let messageApp = document.getElementById("messages_doctor_app")
        messageApp.style.display = "block"
      }
    });
  }
}
