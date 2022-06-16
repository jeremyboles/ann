//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function mounted() {
  const styles = window.getComputedStyle(this.el)
  if (styles.gridTemplateRows === "masonry") return

  const columns = styles.gridTemplateColumns.split(" ").length
  const gap = Number.parseFloat(styles.rowGap)

  if (columns > 1) {
    const items = [...this.el.children]
    items.slice(columns).forEach((column, i) => {
      const end = items[i].getBoundingClientRect().bottom
      const start = column.getBoundingClientRect().top

      column.style.marginBlockStart = `${end + gap - start}px`
    })
  }
}
