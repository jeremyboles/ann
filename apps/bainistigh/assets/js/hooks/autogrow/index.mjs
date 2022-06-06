//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function mounted() {
  this.el.addEventListener("input", autogrow)
}

export function destroyed() {
  this.el.removeEventListener("input", autogrow)
}

//
// Private functions
// -----------------------------------------------------------------------------------------------

function autogrow(event) {
  event.currentTarget.style.blockSize = "inherit"

  const computed = window.getComputedStyle(event.currentTarget)
  const height = parseFloat(computed.paddingBlockStart) + event.currentTarget.scrollHeight + parseFloat(computed.paddingBlockEnd)

  event.currentTarget.style.blockSize = `${height}px`
}
