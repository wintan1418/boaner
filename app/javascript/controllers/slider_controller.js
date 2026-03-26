import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "dot"]
  static values = { interval: { type: Number, default: 5000 } }

  connect() {
    this.index = 0
    this.total = this.slideTargets.length
    if (this.total > 1) {
      this.timer = setInterval(() => this.next(), this.intervalValue)
    }
    this.show()
  }

  disconnect() {
    clearInterval(this.timer)
  }

  next() {
    this.index = (this.index + 1) % this.total
    this.show()
  }

  prev() {
    this.index = (this.index - 1 + this.total) % this.total
    this.show()
  }

  goTo(event) {
    this.index = parseInt(event.currentTarget.dataset.index)
    this.show()
    clearInterval(this.timer)
    this.timer = setInterval(() => this.next(), this.intervalValue)
  }

  show() {
    this.slideTargets.forEach((slide, i) => {
      if (i === this.index) {
        slide.classList.remove("opacity-0")
        slide.classList.add("opacity-100")
      } else {
        slide.classList.remove("opacity-100")
        slide.classList.add("opacity-0")
      }
    })

    if (this.hasDotTarget) {
      this.dotTargets.forEach((dot, i) => {
        if (i === this.index) {
          dot.classList.add("bg-amber-500", "w-8")
          dot.classList.remove("bg-white/40", "w-2.5")
        } else {
          dot.classList.remove("bg-amber-500", "w-8")
          dot.classList.add("bg-white/40", "w-2.5")
        }
      })
    }
  }
}
