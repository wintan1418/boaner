import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card"]

  toggle(event) {
    event.preventDefault()
    this.cardTarget.classList.toggle("hidden")
    if (!this.cardTarget.classList.contains("hidden")) {
      this.cardTarget.style.opacity = "0"
      this.cardTarget.style.transform = "translateY(20px) scale(0.95)"
      requestAnimationFrame(() => {
        this.cardTarget.style.transition = "opacity 0.3s ease, transform 0.3s cubic-bezier(0.16, 1, 0.3, 1)"
        this.cardTarget.style.opacity = "1"
        this.cardTarget.style.transform = "translateY(0) scale(1)"
      })
    }
  }

  close(event) {
    if (!this.element.contains(event.target)) {
      this.cardTarget.classList.add("hidden")
    }
  }

  connect() {
    this.closeHandler = this.close.bind(this)
    document.addEventListener("click", this.closeHandler)
  }

  disconnect() {
    document.removeEventListener("click", this.closeHandler)
  }
}
