import { Controller } from "@hotwired/stimulus"

// Extends Trix with WordPress-like formatting: alignment, font sizes, colors, more headings
export default class extends Controller {
  connect() {
    // Wait for Trix to be ready
    this.setupTrix()
  }

  setupTrix() {
    if (!window.Trix) {
      setTimeout(() => this.setupTrix(), 100)
      return
    }

    const Trix = window.Trix

    // Register text alignment attributes
    if (!Trix.config.textAttributes.alignLeft) {
      Trix.config.textAttributes.alignLeft = { tagName: "div", style: { textAlign: "left" }, inheritable: true }
      Trix.config.textAttributes.alignCenter = { tagName: "div", style: { textAlign: "center" }, inheritable: true }
      Trix.config.textAttributes.alignRight = { tagName: "div", style: { textAlign: "right" }, inheritable: true }
      Trix.config.textAttributes.alignJustify = { tagName: "div", style: { textAlign: "justify" }, inheritable: true }
    }

    // Register block-level alignment styles via CSS
    Trix.config.blockAttributes.alignLeft = { tagName: "div", style: { textAlign: "left" } }
    Trix.config.blockAttributes.alignCenter = { tagName: "div", style: { textAlign: "center" } }
    Trix.config.blockAttributes.alignRight = { tagName: "div", style: { textAlign: "right" } }
    Trix.config.blockAttributes.alignJustify = { tagName: "div", style: { textAlign: "justify" } }

    // Register heading levels
    Trix.config.blockAttributes.heading2 = { tagName: "h2", terminal: true, breakOnReturn: true, group: false }
    Trix.config.blockAttributes.heading3 = { tagName: "h3", terminal: true, breakOnReturn: true, group: false }

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

    // Avoid double-injection
    if (toolbar.querySelector(".custom-toolbar-group")) return

    const buttonGroup = toolbar.querySelector(".trix-button-group--text-tools")
    const blockGroup = toolbar.querySelector(".trix-button-group--block-tools")

    // Add alignment buttons
    const alignmentHTML = `
      <span class="trix-button-group custom-toolbar-group trix-button-group--alignment-tools" data-trix-button-group="alignment-tools">
        <button type="button" class="trix-button" data-trix-attribute="alignLeft" title="Align Left" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="17" y1="10" x2="3" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="17" y1="18" x2="3" y2="18"/></svg>
        </button>
        <button type="button" class="trix-button" data-trix-attribute="alignCenter" title="Align Center" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="10" x2="6" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="18" y1="18" x2="6" y2="18"/></svg>
        </button>
        <button type="button" class="trix-button" data-trix-attribute="alignRight" title="Align Right" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" y1="10" x2="7" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="21" y1="18" x2="7" y2="18"/></svg>
        </button>
        <button type="button" class="trix-button" data-trix-attribute="alignJustify" title="Justify" tabindex="-1">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="21" y1="10" x2="3" y2="10"/><line x1="21" y1="6" x2="3" y2="6"/><line x1="21" y1="14" x2="3" y2="14"/><line x1="21" y1="18" x2="3" y2="18"/></svg>
        </button>
      </span>
    `

    // Add heading buttons (H2, H3)
    const headingHTML = `
      <span class="trix-button-group custom-toolbar-group trix-button-group--heading-tools" data-trix-button-group="heading-tools">
        <button type="button" class="trix-button" data-trix-attribute="heading2" title="Heading 2" tabindex="-1" style="font-weight:bold;font-size:14px;">H2</button>
        <button type="button" class="trix-button" data-trix-attribute="heading3" title="Heading 3" tabindex="-1" style="font-weight:bold;font-size:13px;">H3</button>
      </span>
    `

    // Insert after block tools
    if (blockGroup) {
      blockGroup.insertAdjacentHTML("afterend", alignmentHTML)
      blockGroup.insertAdjacentHTML("afterend", headingHTML)
    } else if (buttonGroup) {
      buttonGroup.insertAdjacentHTML("afterend", alignmentHTML)
      buttonGroup.insertAdjacentHTML("afterend", headingHTML)
    }
  }
}
