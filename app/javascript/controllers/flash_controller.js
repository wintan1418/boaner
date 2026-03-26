import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    this.timeout = setTimeout(() => this.dismiss(), 5000)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }

  dismiss() {
    this.messageTargets.forEach(msg => {
      msg.style.transition = "opacity 300ms, transform 300ms"
      msg.style.opacity = "0"
      msg.style.transform = "translateX(1rem)"
      setTimeout(() => msg.remove(), 300)
    })

    setTimeout(() => this.element.remove(), 350)
  }
}
