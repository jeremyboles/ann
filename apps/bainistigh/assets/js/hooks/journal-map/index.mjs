//
// Exported functions
// -----------------------------------------------------------------------------------------------

export function destroyed() {
  this.preference.removeEventListener("change", this.changeColorScheme)
  this.map?.destroy()
}

export function mounted() {
  this.location = null

  this.button = this.el.querySelector("button:has(span)")
  this.cancel = this.el.querySelector("dialog button")

  this.dialog = this.el.querySelector("dialog")
  this.form = this.el.querySelector("form")
  this.results = this.el.querySelector("ul")
  this.selected = this.el.querySelector("p")

  this.geocoder = new mapkit.Geocoder({ getsUserLocation: true })
  this.search = new mapkit.Search({ getsUserLocation: true })

  this.map = new mapkit.Map(this.el.querySelector(".map"), {
    colorScheme: window.matchMedia("(prefers-color-scheme: dark)").matches ? mapkit.Map.ColorSchemes.Dark : mapkit.Map.ColorSchemes.Light,
    showsUserLocation: true,
    tracksUserLocation: true,
  })

  this.cancel.addEventListener("click", () => {
    this.dialog.close()
  })

  this.map.addEventListener("user-location-change", ({ coordinate }) => {
    if (this.el.querySelector("#entry_coords")?.value) return

    this.map.setRegionAnimated(new mapkit.CoordinateRegion(coordinate, new mapkit.CoordinateSpan(0.005, 0.005)))

    const search = new mapkit.PointsOfInterestSearch({
      pointOfInterestFilter: mapkit.PointOfInterestFilter.including([mapkit.PointOfInterestCategory.Bakery, mapkit.PointOfInterestCategory.Cafe, mapkit.PointOfInterestCategory.Hotel, mapkit.PointOfInterestCategory.Restaurant]),
      region: new mapkit.CoordinateRegion(coordinate, new mapkit.CoordinateSpan(0.03, 0.03)),
    })

    search.search((error, data) => {
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
          this.selected.innerHTML = `<span>${r.name}</span>`

          if (this.location) this.map.removeAnnotation(this.location)
          this.location = new mapkit.MarkerAnnotation(r.coordinate)
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
        console.log(data)
        const [response] = data.results
        this.selected.innerHTML = `<span>${response.name}</span>`

        const { latitude, longitude } = coordinate
        const payload = { coords: { latitude, longitude }, mapkit_response: response }
        this.pushEventTo("#display-component", "update", payload)
      })
    }
  })

  this.map.addEventListener("long-press", ({ pointOnPage }) => {
    const coords = this.map.convertPointOnPageToCoordinate(pointOnPage)
    if (this.location) this.map.removeAnnotation(this.location)

    this.location = new mapkit.MarkerAnnotation(coords)
    this.map.addAnnotation(this.location)

    this.geocoder.reverseLookup(coords, (_, data) => {
      if (data.results.length === 0) return
      this.selected.innerHTML = `<span>${data.results[0].name}</span>`
    })
  })

  this.map.addEventListener("select", ({ annotation }) => {
    if (annotation.coordinate) {
      if (this.location) this.map.removeAnnotation(this.location)

      this.location = new mapkit.MarkerAnnotation(annotation.coordinate)
      this.map.addAnnotation(this.location)

      this.geocoder.reverseLookup(annotation.coordinate, (_, data) => {
        if (data.results.length === 0) return
        this.selected.innerHTML = `<span>${data.results[0].name}</span>`
      })
    }
  })

  window.requestAnimationFrame(() => {
    const coords = this.el.querySelector("#entry_coords")
    if (coords.value) {
      const [lng, lat] = JSON.parse(coords.value).coordinates
      const coordinate = new mapkit.Coordinate(Number.parseFloat(lat), Number.parseFloat(lng))

      this.location = new mapkit.MarkerAnnotation(coordinate)
      this.map.addAnnotation(this.location)

      const span = new mapkit.CoordinateSpan(0.003, 0.003)
      const region = new mapkit.CoordinateRegion(coordinate, span)
      this.map.setRegionAnimated(region)

      const response = JSON.parse(this.el.querySelector("#entry_mapkit_response").value)
      this.selected.innerHTML = `<span>${response.name}</span>`
    }
  })

  this.changeColorScheme = changeColorScheme.bind(this.map)

  this.preference = window.matchMedia("(prefers-color-scheme: dark)")
  this.preference.addEventListener("change", this.changeColorScheme)

  this.suggestions = document.getElementById("journal-map-suggestions")

  this.input = this.el.querySelector("input[type='search']")
  this.input.addEventListener("keypress", ({ currentTarget }) => {
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
            this.selected.innerHTML = `<span>${r.name}</span>`

            if (this.location) this.map.removeAnnotation(this.location)
            this.location = new mapkit.MarkerAnnotation(r.coordinate)
            this.map.addAnnotation(this.location)

            const span = new mapkit.CoordinateSpan(0.003, 0.003)
            const region = new mapkit.CoordinateRegion(r.coordinate, span)
            this.map.setRegionAnimated(region)

            const { latitude, longitude } = r.coordinate
            const payload = { coords: { latitude, longitude }, mapkit_response: r }
            this.pushEventTo("#display-component", "update", payload)
            this.dialog.close()
          })

          this.dialog.showModal()

          return item
        })
        this.results.replaceChildren(...items)
      })
    }
  })
  this.input.addEventListener("input", (event) => {
    console.log(event)
    if (!event.inputType) {
      const option = this.suggestions.querySelector(`[value="${event.srcElement.value}"]`)
      if (!option) return

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
            this.selected.innerHTML = `<span>${r.name}</span>`

            if (this.location) this.map.removeAnnotation(this.location)
            this.location = new mapkit.MarkerAnnotation(r.coordinate)
            this.map.addAnnotation(this.location)

            const span = new mapkit.CoordinateSpan(0.003, 0.003)
            const region = new mapkit.CoordinateRegion(r.coordinate, span)
            this.map.setRegionAnimated(region)

            const { latitude, longitude } = r.coordinate
            const payload = { coords: { latitude, longitude }, mapkit_response: r }
            this.pushEventTo("#display-component", "update", payload)
            this.dialog.close()
          })

          return item
        })
        this.results.replaceChildren(...items)
      })

      this.dialog.showModal()
    }
  })

  this.button.addEventListener("click", (event) => {
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
          this.selected.innerHTML = `<span>${r.name}</span>`

          if (this.location) this.map.removeAnnotation(this.location)
          this.location = new mapkit.MarkerAnnotation(r.coordinate)
          this.map.addAnnotation(this.location)

          const span = new mapkit.CoordinateSpan(0.003, 0.003)
          const region = new mapkit.CoordinateRegion(r.coordinate, span)
          this.map.setRegionAnimated(region)

          const { latitude, longitude } = r.coordinate
          const payload = { coords: { latitude, longitude }, mapkit_response: r }
          this.pushEventTo("#display-component", "update", payload)
          this.dialog.close()
        })

        this.dialog.showModal()

        return item
      })
      this.results.replaceChildren(...items)
    })
  })
}

//
// Private functions
// -----------------------------------------------------------------------------------------------

function changeColorScheme(event) {
  this.colorScheme = event?.matches ? mapkit.Map.ColorSchemes.Dark : mapkit.Map.ColorSchemes.Light
}
