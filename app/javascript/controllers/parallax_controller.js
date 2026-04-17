import { Controller } from "@hotwired/stimulus"

// Moves the element slower than scroll for parallax effect
export default class extends Controller {
  static values = { speed: { type: Number, default: 0.3 } }

  connect() {
    this.onScroll = this.update.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
    this.update()
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
  }

  update() {
    const rect = this.element.getBoundingClientRect()
    const windowH = window.innerHeight
    if (rect.bottom < 0 || rect.top > windowH) return
    const scrolled = (windowH - rect.top) * this.speedValue
    this.element.style.transform = `translate3d(0, ${scrolled * -0.1}px, 0) scale(1.08)`
  }
}
