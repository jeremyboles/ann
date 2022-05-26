//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function destroyed() {
  console.info("TagList destroyed()")
  this.observer.disconnect()
}

export function mounted() {
  console.info("TagList mounted()")

  // Set up a listener function to deal with "advanced" key bindings while adding tags
  this.keydown = (event) => {
    if (event.key === "Enter" && event.shiftKey) {
      event.preventDefault()
      event.currentTarget.blur()
      this.pushEventTo("#add-tag-button", "add-tag")
    } else if (event.key === "Enter" || event.key === "Escape") {
      event.preventDefault()
      event.currentTarget.blur()
    } else if (event.key === "Backspace" && (event.shiftKey || event.currentTarget.value === "")) {
      event.preventDefault()
      event.currentTarget.parentNode.previousElementSibling?.querySelector("input")?.focus()
      event.currentTarget.parentNode.remove()
    }
  }

  // Add keydown listener to the initial inputs available
  this.el.querySelectorAll("input").forEach((input) => input.addEventListener("keydown", this.keydown))

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
