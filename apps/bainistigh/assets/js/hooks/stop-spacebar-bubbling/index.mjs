//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function mounted() {
  this.el.addEventListener("keyup", stopSpaceBar)
}

export function destroyed() {
  this.el.removeEventListener("keyup", stopSpaceBar)
}

//
// Private functions
// -----------------------------------------------------------------------------------------------

function stopSpaceBar(event) {
  if (event.code == "Space") event.preventDefault()
}
