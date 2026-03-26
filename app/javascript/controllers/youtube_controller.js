import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { id: String }
  static targets = ["player", "hint"]

  connect() {
    this.loaded = false
  }

  load() {
    if (this.loaded) return

    this.playerTarget.innerHTML =
      `<iframe src="https://www.youtube.com/embed/${this.idValue}?autoplay=1&rel=0"
        class="w-full h-full rounded-xl" frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen></iframe>`
    this.playerTarget.classList.remove("hidden")
    this.element.querySelector("img")?.classList.add("hidden")

    if (this.hasHintTarget) {
      this.hintTarget.classList.add("hidden")
    }

    // Hide the play button overlay
    const overlay = this.element.querySelector("[data-action]")
    if (overlay && overlay !== this.playerTarget) {
      overlay.style.pointerEvents = "none"
      const playBtn = overlay.querySelector("div.absolute")
      if (playBtn) playBtn.classList.add("hidden")
    }

    this.loaded = true
  }
}
