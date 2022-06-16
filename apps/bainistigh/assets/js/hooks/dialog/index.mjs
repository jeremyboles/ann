export function mounted() {
  this.handleEvent("close-dialog", () => this.el.close())
  this.handleEvent("open-dialog", () => this.el.showModal())
}
