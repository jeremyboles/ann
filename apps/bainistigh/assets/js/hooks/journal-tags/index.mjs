//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function mounted() {
  const input = this.el.querySelector("#journal-tags-input")

  this.handleEvent("update-tags", ({ blur, tags }) => {
    this.pushEventTo("#display-component", "update", { tags })

    input.value = ""
    if (blur) input.blur()
  })
}
