import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.element.setAttribute("novalidate", "")
    this.element.addEventListener("submit", this.validate.bind(this))
  }

  validate(event) {
    // Clear previous errors
    this.element.querySelectorAll(".field-error").forEach(el => el.remove())
    this.element.querySelectorAll(".border-red-300").forEach(el => {
      el.classList.remove("border-red-300")
      el.classList.add("border-warm-200")
    })

    const inputs = this.element.querySelectorAll("[required]")
    let valid = true

    inputs.forEach(input => {
      if (!input.value.trim()) {
        valid = false
        input.classList.remove("border-warm-200")
        input.classList.add("border-red-300")
        const error = document.createElement("p")
        error.className = "field-error text-red-500 text-xs mt-1"
        error.textContent = "This field is required"
        input.parentNode.appendChild(error)
      }

      if (input.type === "email" && input.value && !input.value.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
        valid = false
        input.classList.remove("border-warm-200")
        input.classList.add("border-red-300")
        const error = document.createElement("p")
        error.className = "field-error text-red-500 text-xs mt-1"
        error.textContent = "Please enter a valid email"
        input.parentNode.appendChild(error)
      }
    })

    if (!valid) event.preventDefault()
  }
}
