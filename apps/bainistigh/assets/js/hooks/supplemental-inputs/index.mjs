//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function destroyed() {
  this.observer.disconnect()
}

export function mounted() {
  // Set up a listener function to deal with "advanced" key bindings while adding tags
  this.keydown = (event) => {
    if (event.key === "Enter") {
      event.preventDefault()
      if (event.shiftKey) {
        const params = { "appendix-id": this.el.getAttribute("phx-value-appendix-id") }
        this.pushEventTo(this.el.form, "add-to-appendix", params)
      } else {
        if (event.currentTarget.nextElementSibling === null) {
          event.currentTarget.blur()
          if (event.shiftKey) console.debug("NEXT/NEW")
        } else {
          event.currentTarget.nextElementSibling.focus()
        }
      }
    } else if (event.key === "Escape") {
      event.preventDefault()
      event.currentTarget.blur()
    } else if (event.key === "Backspace" && (event.shiftKey || event.currentTarget.value === "")) {
      event.preventDefault()
      if (event.currentTarget.previousElementSibling === null) {
        const params = { "appendix-id": this.el.getAttribute("phx-value-appendix-id"), id: this.el.getAttribute("phx-value-id") }
        this.pushEventTo(this.el.form, "remove-from-appendix", params)
      } else {
        if (event.shiftKey) event.currentTarget.value = ""
        event.currentTarget.previousElementSibling.focus()
      }
    }
  }

  // Add keydown listener to the initial inputs available
  this.el.querySelectorAll("input, textarea").forEach((input) => input.addEventListener("keydown", this.keydown))

  // Set up an observer to see when any new tags have been added or removed
  this.observer = new MutationObserver((mutations) => {
    console.log(mutations)
    for (const mutation of mutations) {
      if (mutation.type === "childList") {
        // Newly added inputs
        for (const node of mutation.addedNodes) {
          if (node.tagName === "LI") {
            const input = node.querySelector("input")

            // Add the keydown listener
            input.addEventListener("keydown", this.keydown)

            // Focus the newly-inserted input
            if (input?.value === "") input.focus()
          }
        }
      }
    }
  })
  this.observer.observe(this.el, { childList: true })
}
