//
// Exported functions
// -----------------------------------------------------------------------------------------------

// export function beforeUpdate() {
//   console.log('[BEFORE UPDATE]')
// }

export function destroyed() {
  // console.log('[DESTROYED]')
  this.preference.removeEventListener('change', this.changeColorScheme)
  this.map?.destroy()
}

// export function disconnected() {
//   console.log('[DISCONNECTED]')
// }

export function mounted() {
  // console.log('[MOUNTED]')

  this.map = new mapkit.Map(this.el, {
    colorScheme: window.matchMedia('(prefers-color-scheme: dark)').matches
      ? mapkit.Map.ColorSchemes.Dark
      : mapkit.Map.ColorSchemes.Light,
  })

  this.changeColorScheme = changeColorScheme.bind(this.map)

  this.preference = window.matchMedia('(prefers-color-scheme: dark)')
  this.preference.addEventListener('change', this.changeColorScheme)
}

// export function reconnected() {
//   console.log('[RECONNNECTED]')
// }
//
// export function updated() {
//   console.log('[UPDATED]')
// }

//
// Private functions
// -----------------------------------------------------------------------------------------------

function changeColorScheme(event) {
  this.colorScheme = event?.matches
    ? mapkit.Map.ColorSchemes.Dark
    : mapkit.Map.ColorSchemes.Light
}
