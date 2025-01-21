import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "arrow"]

  connect() {
    console.log("Dropdown controller connected!")
    document.addEventListener("click", this.closeOnClickOutside.bind(this))
  }

  disconnect() {
    console.log("Dropdown controller disconnected!")
    document.removeEventListener("click", this.closeOnClickOutside.bind(this))
  }

  toggle(event) {
    console.log("Toggle called!")
    event.stopPropagation()
    this.menuTarget.classList.toggle("hidden")
    this.arrowTarget.classList.toggle("rotate-180")
  }

  closeOnClickOutside(event) {
    console.log("Close on click outside called!")
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
      this.arrowTarget.classList.remove("rotate-180")
    }
  }
} 