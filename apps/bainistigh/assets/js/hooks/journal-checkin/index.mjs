//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function destroyed() {
  this.preference.removeEventListener("change", this.changeColorScheme)
  this.map?.destroy()
}

export function mounted() {
  this.location = null

  this.results = this.el.querySelector("ul")
  this.suggestions = this.el.querySelector("#checkin-suggestions")

  this.geocoder = new mapkit.Geocoder({ getsUserLocation: true })
  this.search = new mapkit.Search({ getsUserLocation: true })

  this.map = new mapkit.Map(this.el.querySelector(".map"), {
    colorScheme: window.matchMedia("(prefers-color-scheme: dark)").matches ? mapkit.Map.ColorSchemes.Dark : mapkit.Map.ColorSchemes.Light,
    showsUserLocation: true,
    tracksUserLocation: true,
  })

  this.changeColorScheme = changeColorScheme.bind(this.map)
  this.preference = window.matchMedia("(prefers-color-scheme: dark)")
  this.preference.addEventListener("change", this.changeColorScheme)

  this.map.addEventListener("user-location-change", ({ coordinate }) => {
    if (this.el.querySelector("#entry_coords")?.value) return

    this.map.setRegionAnimated(new mapkit.CoordinateRegion(coordinate, new mapkit.CoordinateSpan(0.005, 0.005)))

    const search = new mapkit.PointsOfInterestSearch({
      region: new mapkit.CoordinateRegion(coordinate, new mapkit.CoordinateSpan(0.03, 0.03)),
    })

    search.search((error, data) => {
      console.log(data)
      if (error) return

      this.results.replaceChildren()
      const items = data.places.map((r) => {
        const item = document.createElement("li")
        item.dataset.category = r.pointOfInterestCategory
        item.dataset.latitude = r.coordinate?.latitude
        item.dataset.longitude = r.coordinate?.longitude
        item.dataset.result = JSON.stringify(r)
        item.innerHTML = `<span><b>${r.name}</b>${r.fullThoroughfare ? `<address>${r.fullThoroughfare}</address>` : ""}</span>`

        item.addEventListener("click", () => {
          if (this.location) this.map.removeAnnotation(this.location)
          this.location = new mapkit.MarkerAnnotation(r.coordinate, { title: r.name })
          this.map.addAnnotation(this.location)

          const span = new mapkit.CoordinateSpan(0.003, 0.003)
          const region = new mapkit.CoordinateRegion(r.coordinate, span)
          this.map.setRegionAnimated(region)

          const { latitude, longitude } = r.coordinate
          const payload = { coords: { latitude, longitude }, mapkit_response: r }
          this.pushEventTo("#display-component", "update", payload)
        })

        return item
      })

      this.results.replaceChildren(...items)
    })

    if (!this.location) {
      this.location = new mapkit.MarkerAnnotation(coordinate)
      this.map.addAnnotation(this.location)

      this.geocoder.reverseLookup(coordinate, (_, data) => {
        const [response] = data.results

        this.location.title = response.name

        const { latitude, longitude } = coordinate
        const payload = { coords: { latitude, longitude }, mapkit_response: response }
        this.pushEventTo("#display-component", "update", payload)
      })
    }
  })

  window.requestAnimationFrame(() => {
    const coords = this.el.querySelector("#entry_coords")
    console.log(coords)
    if (coords.value) {
      const [lng, lat] = JSON.parse(coords.value).coordinates
      const coordinate = new mapkit.Coordinate(Number.parseFloat(lat), Number.parseFloat(lng))

      this.location = new mapkit.MarkerAnnotation(coordinate)
      this.map.addAnnotation(this.location)

      const span = new mapkit.CoordinateSpan(0.003, 0.003)
      const region = new mapkit.CoordinateRegion(coordinate, span)
      this.map.setRegionAnimated(region)

      const response = JSON.parse(this.el.querySelector("#entry_mapkit_response").value)
      this.location.title = response.name
    }
  })

  this.input = this.el.querySelector("input[type='search']")
  this.input.addEventListener("keypress", ({ currentTarget }) => {
    this.search.region = this.map.region
    this.search.autocomplete(currentTarget.value, (error, data) => {
      if (error) return

      const options = data.results.map((r) => {
        const option = document.createElement("option")
        option.dataset.latitude = r.coordinate?.latitude
        option.dataset.longitude = r.coordinate?.longitude
        option.label = r.displayLines
        option.value = r.displayLines
        return option
      })
      this.suggestions.replaceChildren(...options)
    })
  })
  this.input.addEventListener("keydown", (event) => {
    if (event.key === "Enter") {
      this.search.region = this.map.region
      this.search.search(this.input.value, (error, data) => {
        if (error) return

        this.results.replaceChildren()
        const items = data.places.map((r) => {
          const item = document.createElement("li")
          item.dataset.category = r.pointOfInterestCategory
          item.dataset.latitude = r.coordinate?.latitude
          item.dataset.longitude = r.coordinate?.longitude
          item.dataset.result = JSON.stringify(r)
          item.innerHTML = `<span><b>${r.name}</b>${r.fullThoroughfare ? `<address>${r.fullThoroughfare}</address>` : ""}</span>`

          item.addEventListener("click", (event) => {
            if (this.location) this.map.removeAnnotation(this.location)
            this.location = new mapkit.MarkerAnnotation(r.coordinate, { title: r.name })
            this.map.addAnnotation(this.location)

            const span = new mapkit.CoordinateSpan(0.003, 0.003)
            const region = new mapkit.CoordinateRegion(r.coordinate, span)
            this.map.setRegionAnimated(region)

            const { latitude, longitude } = r.coordinate
            const payload = { coords: { latitude, longitude }, mapkit_response: r }
            this.pushEventTo("#display-component", "update", payload)
          })

          return item
        })
        this.results.replaceChildren(...items)
      })
    }
  })
  this.input.addEventListener("input", (event) => {
    if (!event.inputType) {
      const option = this.suggestions.querySelector(`[value="${event.srcElement.value}"]`)
      if (option) {
        const { latitude, longitude } = option.dataset

        const coords = new mapkit.Coordinate(Number.parseFloat(latitude), Number.parseFloat(longitude))
        const span = new mapkit.CoordinateSpan(0.02, 0.02)
        const region = new mapkit.CoordinateRegion(coords, span)
        this.map.setRegionAnimated(region)
        this.search.region = region

        this.search.search(event.srcElement.value, (error, data) => {
          if (error) return

          this.results.replaceChildren()
          const items = data.places.map((r) => {
            const item = document.createElement("li")
            item.dataset.category = r.pointOfInterestCategory
            item.dataset.latitude = r.coordinate?.latitude
            item.dataset.longitude = r.coordinate?.longitude
            item.dataset.result = JSON.stringify(r)
            item.innerHTML = `<span><b>${r.name}</b>${r.fullThoroughfare ? `<address>${r.fullThoroughfare}</address>` : ""}</span>`

            item.addEventListener("click", (event) => {
              if (this.location) this.map.removeAnnotation(this.location)
              this.location = new mapkit.MarkerAnnotation(r.coordinate, { title: r.name })
              this.map.addAnnotation(this.location)

              const span = new mapkit.CoordinateSpan(0.003, 0.003)
              const region = new mapkit.CoordinateRegion(r.coordinate, span)
              this.map.setRegionAnimated(region)

              const { latitude, longitude } = r.coordinate
              const payload = { coords: { latitude, longitude }, mapkit_response: r }
              this.pushEventTo("#display-component", "update", payload)
            })

            return item
          })
          this.results.replaceChildren(...items)
        })
      } else if (event.srcElement.value === "") {
        this.search.region = this.map.region
        this.search.search((error, data) => {
          if (error) return

          this.results.replaceChildren()
          const items = data.places.map((r) => {
            const item = document.createElement("li")
            item.dataset.category = r.pointOfInterestCategory
            item.dataset.latitude = r.coordinate?.latitude
            item.dataset.longitude = r.coordinate?.longitude
            item.dataset.result = JSON.stringify(r)
            item.innerHTML = `<span><b>${r.name}</b>${r.fullThoroughfare ? `<address>${r.fullThoroughfare}</address>` : ""}</span>`

            item.addEventListener("click", () => {
              if (this.location) this.map.removeAnnotation(this.location)
              this.location = new mapkit.MarkerAnnotation(r.coordinate, { title: r.name })
              this.map.addAnnotation(this.location)

              const span = new mapkit.CoordinateSpan(0.003, 0.003)
              const region = new mapkit.CoordinateRegion(r.coordinate, span)
              this.map.setRegionAnimated(region)

              const { latitude, longitude } = r.coordinate
              const payload = { coords: { latitude, longitude }, mapkit_response: r }
              this.pushEventTo("#display-component", "update", payload)
            })

            return item
          })

          this.results.replaceChildren(...items)
        })
      }
    }
  })
}

//
// Private functions
// -----------------------------------------------------------------------------------------------

function changeColorScheme(event) {
  this.colorScheme = event?.matches ? mapkit.Map.ColorSchemes.Dark : mapkit.Map.ColorSchemes.Light
}
