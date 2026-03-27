import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "openIcon", "closeIcon", "header"]

  connect() {
    this.onScroll = this.scroll.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
  }

  scroll() {
    if (window.scrollY > 50) {
      this.element.classList.add("shadow-lg", "bg-white/95")
      this.element.classList.remove("bg-white/80")
    } else {
      this.element.classList.remove("shadow-lg", "bg-white/95")
      this.element.classList.add("bg-white/80")
    }
  }

  toggle() {
    const isHidden = this.menuTarget.classList.contains("hidden")
    if (isHidden) {
      this.menuTarget.classList.remove("hidden")
      this.menuTarget.style.maxHeight = "0"
      this.menuTarget.style.opacity = "0"
      requestAnimationFrame(() => {
        this.menuTarget.style.transition = "max-height 0.3s ease, opacity 0.3s ease"
        this.menuTarget.style.maxHeight = "400px"
        this.menuTarget.style.opacity = "1"
      })
    } else {
      this.menuTarget.style.transition = "max-height 0.3s ease, opacity 0.3s ease"
      this.menuTarget.style.maxHeight = "0"
      this.menuTarget.style.opacity = "0"
      setTimeout(() => this.menuTarget.classList.add("hidden"), 300)
    }
    this.openIconTarget.classList.toggle("hidden")
    this.closeIconTarget.classList.toggle("hidden")
  }
}
