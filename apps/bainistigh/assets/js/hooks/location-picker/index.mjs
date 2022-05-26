//
// Exported functions
// -----------------------------------------------------------------------------------------------

// export function beforeUpdate() {
//   console.log('[BEFORE UPDATE]')
// }

export function destroyed() {
  // console.log('[DESTROYED]')
  this.preference.removeEventListener("change", this.changeColorScheme)
  this.map?.destroy()
}

// export function disconnected() {
//   console.log('[DISCONNECTED]')
// }

export function mounted() {
  console.log("[MOUNTED]", this.el)

  this.geocoder = new mapkit.Geocoder({ getsUserLocation: true })
  this.map = new mapkit.Map(this.el, {
    colorScheme: window.matchMedia("(prefers-color-scheme: dark)").matches ? mapkit.Map.ColorSchemes.Dark : mapkit.Map.ColorSchemes.Light,
    showsUserLocation: true,
    tracksUserLocation: true,
  })

  this.map.addEventListener("user-location-change", ({ coordinate }) => {
    const { latitude, longitude } = coordinate
    document.getElementById(this.el.dataset.coordsInput).value = `${latitude} ${longitude}`

    this.geocoder.reverseLookup(coordinate, (_, data) => {
      document.getElementById(this.el.dataset.mapkitResponseInput).value = JSON.stringify(data)
    })
  })

  this.changeColorScheme = changeColorScheme.bind(this.map)

  this.preference = window.matchMedia("(prefers-color-scheme: dark)")
  this.preference.addEventListener("change", this.changeColorScheme)
}

// export function reconnected() {
//   console.log('[RECONNNECTED]')
// }
//
export function updated() {
  console.log("[UPDATED]", this.map)
}

//
// Private functions
// -----------------------------------------------------------------------------------------------

function changeColorScheme(event) {
  this.colorScheme = event?.matches ? mapkit.Map.ColorSchemes.Dark : mapkit.Map.ColorSchemes.Light
}
