import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input"]

  toggle() {
    this.formTarget.classList.toggle("hidden")
    if (!this.formTarget.classList.contains("hidden")) {
      this.inputTarget.focus()
    }
  }

  submit(event) {
    event.preventDefault()
    const query = this.inputTarget.value.trim()
    if (query) {
      window.location.href = `/search?q=${encodeURIComponent(query)}`
    }
  }
}
