//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function disconnected() {
  this.observer.disconnect()
}

export function mounted() {
  this.tags = tags(this.el)

  this.observer = new MutationObserver((mutations) => {
    for (const mutation of mutations) {
      if (mutation.type === 'childList') {
        for (const node of mutation.addedNodes) {
          if (node.tagName === 'LI') {
            // NOTE: do we need to clean up this listener before the node is removed or does the
            // browser handle clean up?
            node.querySelector('input').addEventListener('keydown', () => {
              // Since we use the enter key as a shortcut to add a new tag, prevent the browser's
              // default behavior, which is to submit the form.
              if (event.key === 'Enter') event.preventDefault()

              // Remove focus from the input that is being "deleted" so Phoenix can update the value
              // of the input properly. The focus should be set properly in the update function
              // down below.
              if (event.key === 'Backspace' && event.target.value === '') event.target.blur()
            })
          }
        }
      }
    }
  })
  this.observer.observe(this.el, { childList: true })
}

export function updated() {
  const updated = tags(this.el)

  // If a new tag has been added, focus the new input for that tag
  if (updated.length > this.tags.length) {
    this.el.querySelector('input[value=""]')?.focus()
  }

  // If a tag has been removed, focus on the input of the previous input, unless
  // the first tag was the one that was deleted, then focus on the first input
  if (updated.length < this.tags.length) {
    const index = this.tags.findIndex((t) => t === '') || 1
    this.el.querySelector(`input[phx-value-index="${index - 1}"]`)?.focus()
  }

  this.tags = updated
}

//
// Private functions
// -----------------------------------------------------------------------------------------------

function tags(el) {
  const matches = el.querySelectorAll('input[phx-keydown="modify-tags"]')
  return [...matches].map((t) => t.value)
}
