import { Controller } from "@hotwired/stimulus"

// Extends Trix with WordPress-like formatting: alignment, headings
// Uses document.execCommand for alignment since Trix doesn't natively support it
export default class extends Controller {
  connect() {
    this.setupTrix()
  }

  setupTrix() {
    if (!window.Trix) {
      setTimeout(() => this.setupTrix(), 100)
      return
    }

    const Trix = window.Trix

    // Register heading levels
    if (!Trix.config.blockAttributes.heading2) {
      Trix.config.blockAttributes.heading2 = { tagName: "h2", terminal: true, breakOnReturn: true, group: false }
    }
    if (!Trix.config.blockAttributes.heading3) {
      Trix.config.blockAttributes.heading3 = { tagName: "h3", terminal: true, breakOnReturn: true, group: false }
    }

    this.enhanceToolbar()
  }

  enhanceToolbar() {
    const trixEditor = this.element.querySelector("trix-editor")
    if (!trixEditor) {
      setTimeout(() => this.enhanceToolbar(), 100)
      return
    }

    const toolbar = this.element.querySelector("trix-toolbar")
    if (!toolbar) return

    if (toolbar.querySelector(".custom-toolbar-group")) return

    const blockGroup = toolbar.querySelector(".trix-button-group--block-tools")
    const buttonRow = toolbar.querySelector(".trix-button-row") || toolbar.firstElementChild

    // Headings
    const headingHTML = `
      <span class="trix-button-group custom-toolbar-group trix-button-group--heading-tools">
        <button type="button" class="trix-button" data-trix-attribute="heading2" title="Heading 2" tabindex="-1" style="font-weight:bold;font-size:13px;">H2</button>
        <button type="button" class="trix-button" data-trix-attribute="heading3" title="Heading 3" tabindex="-1" style="font-weight:bold;font-size:12px;">H3</button>
      </span>
    `

    // Alignment buttons (we'll wire them manually)
    const alignmentHTML = `
      <span class="trix-button-group custom-toolbar-group trix-button-group--alignment-tools">
        <button type="button" class="trix-button trix-align-btn" data-align="left" title="Align Left" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="17" y1="10" x2="3" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="17" y1="18" x2="3" y2="18"/></svg>
        </button>
        <button type="button" class="trix-button trix-align-btn" data-align="center" title="Align Center" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="10" x2="6" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="18" y1="18" x2="6" y2="18"/></svg>
        </button>
        <button type="button" class="trix-button trix-align-btn" data-align="right" title="Align Right" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="21" y1="10" x2="7" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="21" y1="18" x2="7" y2="18"/></svg>
        </button>
        <button type="button" class="trix-button trix-align-btn" data-align="justify" title="Justify" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="21" y1="10" x2="3" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="21" y1="18" x2="3" y2="18"/></svg>
        </button>
      </span>
    `

    if (blockGroup) {
      blockGroup.insertAdjacentHTML("afterend", alignmentHTML)
      blockGroup.insertAdjacentHTML("afterend", headingHTML)
    }

    // Wire alignment buttons — manipulate DOM directly inside the editor
    toolbar.querySelectorAll(".trix-align-btn").forEach(btn => {
      btn.addEventListener("click", (e) => {
        e.preventDefault()
        e.stopPropagation()
        this.applyAlignment(btn.dataset.align, trixEditor)
      })
    })
  }

  applyAlignment(alignment, trixEditor) {
    // Focus the editor first
    trixEditor.focus()

    // Find the block-level parent of the current selection inside the editor
    const sel = window.getSelection()
    if (!sel.rangeCount) return

    const editorEl = trixEditor

    // Helper: walk up from a node to find the block-level child of editor
    const findBlock = (node) => {
      let n = node.nodeType === Node.TEXT_NODE ? node.parentNode : node
      while (n && n !== editorEl) {
        // Block elements Trix uses
        if (n.parentNode === editorEl ||
            ["DIV", "P", "H1", "H2", "H3", "H4", "BLOCKQUOTE", "PRE", "LI"].includes(n.tagName)) {
          return n
        }
        n = n.parentNode
      }
      return n
    }

    // Apply to all blocks within the selection
    const range = sel.getRangeAt(0)
    const startBlock = findBlock(range.startContainer)
    const endBlock = findBlock(range.endContainer)

    const blocksToAlign = new Set()
    if (startBlock) blocksToAlign.add(startBlock)
    if (endBlock) blocksToAlign.add(endBlock)

    // If selection spans multiple blocks, collect them all
    if (startBlock && endBlock && startBlock !== endBlock) {
      let node = startBlock
      while (node && node !== endBlock) {
        blocksToAlign.add(node)
        node = node.nextElementSibling
      }
      blocksToAlign.add(endBlock)
    }

    // If nothing found, apply to all direct children of editor
    if (blocksToAlign.size === 0) {
      Array.from(editorEl.children).forEach(child => blocksToAlign.add(child))
    }

    blocksToAlign.forEach(block => {
      if (block && block.style) {
        block.style.textAlign = alignment
      }
    })

    // Sync change back to Trix's input element
    const trixInput = document.getElementById(trixEditor.getAttribute("input"))
    if (trixInput) {
      trixInput.value = trixEditor.innerHTML
    }
  }
}
