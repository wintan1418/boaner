import { Controller } from "@hotwired/stimulus"
import Quill from "quill"

// Replaces Trix with Quill — full-featured rich text editor with
// native alignment, colors, font sizes, etc.
export default class extends Controller {
  connect() {
    // Find Trix's hidden input (used by ActionText) and editor
    const trixInput = this.element.querySelector("input[type='hidden']")
    const trixEditor = this.element.querySelector("trix-editor")
    const trixToolbar = this.element.querySelector("trix-toolbar")

    if (!trixInput) return

    // Hide Trix UI
    if (trixEditor) trixEditor.style.display = "none"
    if (trixToolbar) trixToolbar.style.display = "none"

    // Create Quill container
    const container = document.createElement("div")
    container.className = "quill-wrapper"
    container.style.minHeight = "300px"
    container.style.background = "white"
    this.element.appendChild(container)

    // Initialize Quill
    this.quill = new Quill(container, {
      theme: "snow",
      placeholder: "Start writing...",
      modules: {
        toolbar: [
          [{ header: [1, 2, 3, 4, false] }],
          ["bold", "italic", "underline", "strike"],
          [{ color: [] }, { background: [] }],
          [{ list: "ordered" }, { list: "bullet" }],
          [{ indent: "-1" }, { indent: "+1" }],
          [{ align: [] }],
          ["blockquote", "code-block"],
          ["link", "image"],
          ["clean"]
        ]
      }
    })

    // Load existing content from Trix's hidden input
    const existing = trixInput.value
    if (existing && existing.trim()) {
      this.quill.clipboard.dangerouslyPasteHTML(existing)
    }

    // Sync Quill changes back to the hidden input
    this.quill.on("text-change", () => {
      const html = this.quill.root.innerHTML
      // Quill uses <p><br></p> for empty — normalize
      trixInput.value = (html === "<p><br></p>") ? "" : html
    })
  }
}
