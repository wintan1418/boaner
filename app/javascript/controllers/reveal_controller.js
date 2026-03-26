import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "canvas", "text1", "text2", "text3", "subtitle", "cta"]

  connect() {
    const playCount = parseInt(localStorage.getItem("boaner_reveal_count") || "0")
    if (playCount >= 3) {
      this.element.remove()
      return
    }

    document.body.style.overflow = "hidden"
    this.particles = []
    this.ctx = this.canvasTarget.getContext("2d")
    this.resize()
    window.addEventListener("resize", () => this.resize())

    // Start the show
    setTimeout(() => this.startSequence(), 500)
  }

  resize() {
    this.canvasTarget.width = window.innerWidth
    this.canvasTarget.height = window.innerHeight
  }

  startSequence() {
    // Phase 1: Lightning flashes (0-2s)
    this.lightning(3)

    // Phase 2: Rain starts (1s)
    setTimeout(() => this.startRain(), 1000)

    // Phase 3: "Happy Birthday" appears (2.5s)
    setTimeout(() => {
      this.text1Target.classList.remove("opacity-0", "scale-50")
      this.text1Target.classList.add("opacity-100", "scale-100")
      this.lightning(2)
    }, 2500)

    // Phase 4: "Son of Thunder" appears (4s)
    setTimeout(() => {
      this.text2Target.classList.remove("opacity-0", "translate-y-8")
      this.text2Target.classList.add("opacity-100", "translate-y-0")
      this.lightning(3)
      this.burstParticles()
    }, 4000)

    // Phase 5: Thunder emoji rain (5s)
    setTimeout(() => {
      this.text3Target.classList.remove("opacity-0")
      this.text3Target.classList.add("opacity-100")
      this.startEmojiBurst()
    }, 5500)

    // Phase 6: Subtitle (6.5s)
    setTimeout(() => {
      this.subtitleTarget.classList.remove("opacity-0", "translate-y-4")
      this.subtitleTarget.classList.add("opacity-100", "translate-y-0")
    }, 6500)

    // Phase 7: CTA button (7.5s)
    setTimeout(() => {
      this.ctaTarget.classList.remove("opacity-0", "scale-90")
      this.ctaTarget.classList.add("opacity-100", "scale-100")
    }, 7500)
  }

  lightning(count) {
    let i = 0
    const flash = () => {
      if (i >= count) return
      this.overlayTarget.style.backgroundColor = "rgba(255, 255, 255, 0.15)"
      setTimeout(() => {
        this.overlayTarget.style.backgroundColor = ""
      }, 80)
      setTimeout(() => {
        this.overlayTarget.style.backgroundColor = "rgba(255, 255, 255, 0.08)"
        setTimeout(() => {
          this.overlayTarget.style.backgroundColor = ""
        }, 50)
      }, 150)
      i++
      setTimeout(flash, 300 + Math.random() * 400)
    }
    flash()
  }

  startRain() {
    const ctx = this.ctx
    const w = this.canvasTarget.width
    const h = this.canvasTarget.height
    const drops = []

    for (let i = 0; i < 200; i++) {
      drops.push({
        x: Math.random() * w,
        y: Math.random() * h,
        speed: 4 + Math.random() * 8,
        length: 15 + Math.random() * 25,
        opacity: 0.1 + Math.random() * 0.3
      })
    }

    this.rainInterval = setInterval(() => {
      ctx.clearRect(0, 0, w, h)
      drops.forEach(d => {
        ctx.beginPath()
        ctx.moveTo(d.x, d.y)
        ctx.lineTo(d.x + 1, d.y + d.length)
        ctx.strokeStyle = `rgba(245, 158, 11, ${d.opacity})`
        ctx.lineWidth = 1
        ctx.stroke()
        d.y += d.speed
        if (d.y > h) {
          d.y = -d.length
          d.x = Math.random() * w
        }
      })
    }, 16)
  }

  burstParticles() {
    const ctx = this.ctx
    const cx = this.canvasTarget.width / 2
    const cy = this.canvasTarget.height / 2
    const particles = []

    for (let i = 0; i < 60; i++) {
      const angle = (Math.PI * 2 * i) / 60
      const speed = 3 + Math.random() * 6
      particles.push({
        x: cx, y: cy,
        vx: Math.cos(angle) * speed,
        vy: Math.sin(angle) * speed,
        size: 2 + Math.random() * 4,
        life: 1,
        color: Math.random() > 0.5 ? "245, 158, 11" : "251, 191, 36"
      })
    }

    const animate = () => {
      particles.forEach(p => {
        ctx.beginPath()
        ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2)
        ctx.fillStyle = `rgba(${p.color}, ${p.life})`
        ctx.fill()
        p.x += p.vx
        p.y += p.vy
        p.vy += 0.1
        p.life -= 0.015
      })
      const alive = particles.filter(p => p.life > 0)
      if (alive.length > 0) requestAnimationFrame(animate)
    }
    requestAnimationFrame(animate)
  }

  startEmojiBurst() {
    const emojis = ["⚡", "🌩️", "💛", "🔥", "⭐", "✨", "🎉", "🎂"]
    const container = this.overlayTarget

    let count = 0
    this.emojiInterval = setInterval(() => {
      if (count > 40) {
        clearInterval(this.emojiInterval)
        return
      }

      const el = document.createElement("div")
      el.textContent = emojis[Math.floor(Math.random() * emojis.length)]
      el.style.cssText = `
        position: fixed;
        top: -40px;
        left: ${Math.random() * 100}%;
        font-size: ${20 + Math.random() * 30}px;
        z-index: 10001;
        pointer-events: none;
        animation: emoji-fall ${2 + Math.random() * 3}s linear forwards;
      `
      container.appendChild(el)
      setTimeout(() => el.remove(), 5000)
      count++
    }, 100)
  }

  enter() {
    const count = parseInt(localStorage.getItem("boaner_reveal_count") || "0")
    localStorage.setItem("boaner_reveal_count", String(count + 1))
    clearInterval(this.rainInterval)
    clearInterval(this.emojiInterval)

    // Curtain split reveal
    this.overlayTarget.style.transition = "all 1.2s cubic-bezier(0.77, 0, 0.175, 1)"
    this.overlayTarget.style.clipPath = "circle(0% at 50% 50%)"
    this.overlayTarget.style.opacity = "0"

    setTimeout(() => {
      document.body.style.overflow = ""
      this.element.remove()
    }, 1300)
  }
}
