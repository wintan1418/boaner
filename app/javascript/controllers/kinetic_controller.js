import { Controller } from "@hotwired/stimulus"

// Wraps each word in a span and reveals them one-by-one on scroll into view
export default class extends Controller {
  connect() {
    const text = this.element.textContent.trim()
    const words = text.split(/\s+/)
    this.element.innerHTML = words.map((w, i) => {
      const delay = i * 0.05
      return `<span class="word" style="transition-delay: ${delay}s">${w}&nbsp;</span>`
    }).join("")
    this.element.classList.add("kinetic-reveal")

    this.observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          this.element.classList.add("visible")
          this.observer.unobserve(entry.target)
        }
      })
    }, { threshold: 0.3 })
    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer?.disconnect()
  }
}
