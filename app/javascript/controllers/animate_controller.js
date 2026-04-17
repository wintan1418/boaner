import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { delay: { type: Number, default: 0 } }

  connect() {
    const animClasses = ["fade-in", "reveal-section", "slide-left", "slide-right",
                         "scale-reveal", "blur-reveal", "clip-reveal", "rotate-reveal",
                         "text-reveal", "stagger-smooth", "stagger-children",
                         "image-reveal", "line-grow"]

    // If element doesn't already have an animation class, default to fade-in
    const hasAnimClass = animClasses.some(c => this.element.classList.contains(c))
    if (!hasAnimClass) {
      this.element.classList.add("fade-in")
    }

    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            if (this.delayValue > 0) {
              setTimeout(() => this.element.classList.add("visible"), this.delayValue)
            } else {
              this.element.classList.add("visible")
            }
            this.observer.unobserve(entry.target)
          }
        })
      },
      { threshold: 0.1, rootMargin: "0px 0px -50px 0px" }
    )

    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer?.disconnect()
  }
}
