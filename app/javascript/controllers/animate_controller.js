import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { delay: { type: Number, default: 0 } }

  connect() {
    const animClasses = ["fade-in", "reveal-section", "slide-left", "slide-right",
                         "scale-reveal", "blur-reveal", "clip-reveal", "rotate-reveal",
                         "text-reveal", "stagger-smooth", "stagger-children",
                         "image-reveal", "line-grow"]

    const hasAnimClass = animClasses.some(c => this.element.classList.contains(c))
    if (!hasAnimClass) this.element.classList.add("fade-in")

    const reveal = () => {
      this.element.classList.add("visible")
      // Also mark child elements that have animation classes
      animClasses.forEach(cls => {
        this.element.querySelectorAll("." + cls).forEach(el => el.classList.add("visible"))
      })
    }

    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            if (this.delayValue > 0) setTimeout(reveal, this.delayValue)
            else reveal()
            this.observer.unobserve(entry.target)
          }
        })
      },
      { threshold: 0.05, rootMargin: "0px 0px -20px 0px" }
    )

    this.observer.observe(this.element)

    // Safety net — if for any reason we haven't revealed after 2s, reveal anyway
    // so content is never stuck invisible
    this.safetyTimer = setTimeout(reveal, 2000)
  }

  disconnect() {
    this.observer?.disconnect()
    clearTimeout(this.safetyTimer)
  }
}
