import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loader"
export default class extends Controller {
  static targets = ["loader", "submit"]

  connect() {
    console.log("Hello from loader_controller.js")
  }

  loading() {
    console.log("Hello")
    this.submitTarget.classList.add("d-none");
    this.loaderTarget.classList.remove("d-none");
  }
}
