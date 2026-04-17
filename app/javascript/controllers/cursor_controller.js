import { Controller } from "@hotwired/stimulus"

// Custom cursor follower — amber dot that trails the cursor on desktop
export default class extends Controller {
  connect() {
    if (window.matchMedia("(pointer: coarse)").matches) return // skip on touch

    this.dot = document.createElement("div")
    this.dot.className = "cursor-dot"
    document.body.appendChild(this.dot)

    this.ring = document.createElement("div")
    this.ring.className = "cursor-ring"
    document.body.appendChild(this.ring)

    this.mouseX = this.targetX = window.innerWidth / 2
    this.mouseY = this.targetY = window.innerHeight / 2

    this.onMove = (e) => {
      this.mouseX = e.clientX
      this.mouseY = e.clientY
      this.dot.style.transform = `translate(${this.mouseX}px, ${this.mouseY}px)`
    }
    this.onOver = (e) => {
      const target = e.target.closest("a, button, [data-controller*='youtube']")
      if (target) this.ring.classList.add("cursor-hover")
      else this.ring.classList.remove("cursor-hover")
    }

    window.addEventListener("mousemove", this.onMove, { passive: true })
    document.addEventListener("mouseover", this.onOver, { passive: true })

    this.animate()
  }

  animate() {
    this.targetX += (this.mouseX - this.targetX) * 0.15
    this.targetY += (this.mouseY - this.targetY) * 0.15
    if (this.ring) {
      this.ring.style.transform = `translate(${this.targetX}px, ${this.targetY}px)`
    }
    this.raf = requestAnimationFrame(() => this.animate())
  }

  disconnect() {
    window.removeEventListener("mousemove", this.onMove)
    document.removeEventListener("mouseover", this.onOver)
    cancelAnimationFrame(this.raf)
    this.dot?.remove()
    this.ring?.remove()
  }
}
