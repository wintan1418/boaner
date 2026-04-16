import { Controller } from "@hotwired/stimulus"

// Adds alignment buttons to Trix toolbar without breaking default behavior
export default class extends Controller {
  connect() {
    this.tries = 0
    this.enhanceToolbar()
  }

  enhanceToolbar() {
    const trixEditor = this.element.querySelector("trix-editor")
    const toolbar = this.element.querySelector("trix-toolbar")

    if (!trixEditor || !toolbar) {
      if (this.tries++ < 30) {
        setTimeout(() => this.enhanceToolbar(), 100)
      }
      return
    }

    // Avoid double injection
    if (toolbar.querySelector(".rich-align-btn")) return

    const alignmentHTML = `
      <span class="trix-button-group rich-align-group" style="margin-left:6px;">
        <button type="button" class="trix-button rich-align-btn" data-align="left" title="Align Left" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="17" y1="10" x2="3" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="17" y1="18" x2="3" y2="18"/></svg>
        </button>
        <button type="button" class="trix-button rich-align-btn" data-align="center" title="Align Center" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="10" x2="6" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="18" y1="18" x2="6" y2="18"/></svg>
        </button>
        <button type="button" class="trix-button rich-align-btn" data-align="right" title="Align Right" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="21" y1="10" x2="7" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="21" y1="18" x2="7" y2="18"/></svg>
        </button>
        <button type="button" class="trix-button rich-align-btn" data-align="justify" title="Justify" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="21" y1="10" x2="3" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="21" y1="18" x2="3" y2="18"/></svg>
        </button>
      </span>
    `

    // Append to the first row of buttons (most toolbars have one row)
    const buttonRow = toolbar.querySelector(".trix-button-row") || toolbar
    buttonRow.insertAdjacentHTML("beforeend", alignmentHTML)

    // Wire alignment via mousedown to preserve selection
    toolbar.querySelectorAll(".rich-align-btn").forEach(btn => {
      btn.addEventListener("mousedown", (e) => {
        e.preventDefault()
        this.applyAlignment(btn.dataset.align, trixEditor)
      })
    })
  }

  applyAlignment(alignment, trixEditor) {
    const sel = window.getSelection()
    if (!sel || !sel.rangeCount) return

    const editorEl = trixEditor

    const findBlock = (node) => {
      let n = node.nodeType === Node.TEXT_NODE ? node.parentNode : node
      while (n && n !== editorEl) {
        if (n.parentNode === editorEl) return n
        n = n.parentNode
      }
      return null
    }

    const range = sel.getRangeAt(0)
    const startBlock = findBlock(range.startContainer)
    const endBlock = findBlock(range.endContainer)

    const blocks = []
    if (startBlock) blocks.push(startBlock)
    if (endBlock && endBlock !== startBlock) {
      let node = startBlock?.nextElementSibling
      while (node && node !== endBlock) {
        blocks.push(node)
        node = node.nextElementSibling
      }
      blocks.push(endBlock)
    }

    if (blocks.length === 0 && editorEl.children.length > 0) {
      // Fallback: align all blocks
      blocks.push(...Array.from(editorEl.children))
    }

    blocks.forEach(b => {
      if (b && b.style) b.style.textAlign = alignment
    })

    // Sync to hidden input so it persists on form submit
    const inputId = trixEditor.getAttribute("input")
    if (inputId) {
      const input = document.getElementById(inputId)
      if (input) input.value = trixEditor.innerHTML
    }
  }
}
