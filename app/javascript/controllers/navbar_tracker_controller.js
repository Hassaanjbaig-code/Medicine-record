import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar-tracker"
export default class extends Controller {
  static targets = ["content"]
  connect() {
    this.hightlightActiveLink()
  }
  
  hightlightActiveLink(){
    let url = window.location.pathname;
    let links = this.contentTarget.querySelectorAll(".nav-link");
    let classes = ["fw-bold", "text-decoration-underline"]
    links.forEach(link => {
      let href = link.getAttribute("href")
      if (href == url) {
        link.classList.add(...classes)
      } else {
        link.classList.remove(...classes)
      }
    });
  }
}
