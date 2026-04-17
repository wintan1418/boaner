import { Controller } from "@hotwired/stimulus"

// Thin amber bar at the top of the viewport showing scroll progress
export default class extends Controller {
  connect() {
    this.onScroll = this.update.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
    this.update()
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
  }

  update() {
    const doc = document.documentElement
    const scrollTop = window.scrollY
    const height = doc.scrollHeight - doc.clientHeight
    const progress = height > 0 ? Math.min(scrollTop / height, 1) : 0
    this.element.style.transform = `scaleX(${progress})`
  }
}
