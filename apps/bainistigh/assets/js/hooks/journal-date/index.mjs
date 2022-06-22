//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function mounted() {
  console.log("Mounted")
  this.handleEvent("update-datetime", ({ datetime }) => {
    this.pushEventTo("#compose-component", "update", { published_at: datetime })
  })
}
