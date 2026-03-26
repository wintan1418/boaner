import { Controller } from "@hotwired/stimulus"

// Simple scroll-reveal. No fancy stuff.
export default class extends Controller {
  connect() {
    this.element.classList.add("fade-in")

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
