//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function destroyed() {
  this.preference.removeEventListener("change", this.changeColorScheme)
  this.map?.destroy()
}

export function mounted() {
  this.location = null

  this.geocoder = new mapkit.Geocoder({ getsUserLocation: true })
  this.map = new mapkit.Map(this.el, {
    colorScheme: window.matchMedia("(prefers-color-scheme: dark)").matches ? mapkit.Map.ColorSchemes.Dark : mapkit.Map.ColorSchemes.Light,
    showsUserLocation: true,
    tracksUserLocation: true,
  })

  this.map.addEventListener("user-location-change", ({ coordinate }) => {
    this.map.setCenterAnimated(coordinate)

    if (!this.location) {
      this.location = new mapkit.MarkerAnnotation(coordinate)
      this.map.addAnnotation(this.location)

      this.geocoder.reverseLookup(coordinate, (_, data) => {
        const [response] = data.results

        const { latitude, longitude } = coordinate
        this.pushEvent("update-location", { coords: { latitude, longitude }, mapkit_response: response })
      })
    }
  })

  this.map.addEventListener("user-location-error", () => {
    this.pushEvent("get-last-location", {})
  })

  this.map.addEventListener("long-press", ({ pointOnPage }) => {
    const coords = this.map.convertPointOnPageToCoordinate(pointOnPage)
    if (this.location) this.map.removeAnnotation(this.location)

    this.location = new mapkit.MarkerAnnotation(coords)
    this.map.addAnnotation(this.location)

    this.geocoder.reverseLookup(coords, (_, data) => {
      const [response] = data.results

      const { latitude, longitude } = coords
      this.pushEvent("update-location", { coords: { latitude, longitude }, mapkit_response: response })
    })
  })

  this.changeColorScheme = changeColorScheme.bind(this.map)

  this.preference = window.matchMedia("(prefers-color-scheme: dark)")
  this.preference.addEventListener("change", this.changeColorScheme)

  this.handleEvent("last-location-found", ({ latitude, longitude }) => {
    const coords = new mapkit.Coordinate(latitude, longitude)
    const span = new mapkit.CoordinateSpan(0.003, 0.003)
    const region = new mapkit.CoordinateRegion(coords, span)
    this.map.setRegionAnimated(region)
  })

  this.handleEvent("request-location", (payload) => {
    navigator.geolocation.getCurrentPosition(
      ({ coords }) => this.map.setCenterAnimated(new mapkit.Coordinate(coords.latitude, coords.longitude)),
      () => this.pushEvent("get-last-location", {})
    )
  })
}

//
// Private functions
// -----------------------------------------------------------------------------------------------

function changeColorScheme(event) {
  this.colorScheme = event?.matches ? mapkit.Map.ColorSchemes.Dark : mapkit.Map.ColorSchemes.Light
}
