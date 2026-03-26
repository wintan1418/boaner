import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list", "empty"]

  connect() {
    this.render()
  }

  render() {
    const bookmarks = JSON.parse(localStorage.getItem("boaner_bookmarks") || "[]")

    if (bookmarks.length === 0) {
      this.emptyTarget.classList.remove("hidden")
      this.listTarget.classList.add("hidden")
      return
    }

    this.emptyTarget.classList.add("hidden")
    this.listTarget.classList.remove("hidden")
    this.listTarget.innerHTML = bookmarks.map(b => {
      const url = b.type === "video" ? `/videos/${b.id}` : `/blog/${b.id}`
      const typeLabel = b.type.charAt(0).toUpperCase() + b.type.slice(1)
      return `
        <a href="${url}" class="group flex items-center justify-between p-4 bg-white rounded-xl border border-gray-100 hover:border-amber-200 hover:shadow-md transition-all">
          <div>
            <span class="text-xs text-amber-600 font-semibold uppercase tracking-wider">${typeLabel}</span>
            <h3 class="text-gray-900 font-semibold group-hover:text-amber-600 transition-colors mt-1" style="font-family: 'Source Serif 4', Georgia, serif;">${b.title}</h3>
          </div>
          <button data-action="click->reading-list#remove" data-id="${b.id}" data-type="${b.type}" class="p-2 text-gray-300 hover:text-red-500 transition-colors shrink-0" onclick="event.preventDefault(); event.stopPropagation();">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/></svg>
          </button>
        </a>`
    }).join("")
  }

  remove(event) {
    const id = event.currentTarget.dataset.id
    const type = event.currentTarget.dataset.type
    let bookmarks = JSON.parse(localStorage.getItem("boaner_bookmarks") || "[]")
    bookmarks = bookmarks.filter(b => !(b.id === id && b.type === type))
    localStorage.setItem("boaner_bookmarks", JSON.stringify(bookmarks))
    this.render()
  }
}
