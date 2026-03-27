import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Support both fade-in and reveal-section
    if (!this.element.classList.contains("reveal-section")) {
      this.element.classList.add("fade-in")
    }

    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            this.element.classList.add("visible")
            this.observer.unobserve(entry.target)
          }
        })
      },
      { threshold: 0.1 }
    )

    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer?.disconnect()
  }
}
