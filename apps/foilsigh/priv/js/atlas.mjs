import { geoNaturalEarth1, geoPath } from "d3-geo"
import geohash from "ngeohash"
import { feature } from "topojson-client"
import world from "world-atlas/land-110m.json" assert { type: "json" }

export async function map({ height, width }) {
  const { land, projection } = await geoProjection(width, height)
  const path = geoPath().projection(projection)

  return `
    <svg id="map" viewBox="0 0 ${width} ${height}" xmlns="http://www.w3.org/2000/svg">
      <path d="${path(land)}" style="fill: var(--map-fill, currentColor)" />
    </svg>
  `
}

export async function points({ height, radius = 2, width }, options) {
  const { projection } = await geoProjection(width, height)

  let points = ""
  if (Array.isArray(options.locations)) {
    points = options.locations
      .map((hash) => {
        const { latitude, longitude } = geohash.decode(hash)
        const [cx, cy] = projection([longitude, latitude])
        return `<circle cx="${cx}" cy="${cy}" r="${radius}" style="fill: var(--circle-fill, currentColor)" />`
      })
      .join("")
  } else if (typeof options.locations === "object" && options.locations !== null) {
    points = Object.entries(options.locations)
      .map(([group, hashes]) => {
        const circles = hashes
          .map((hash) => {
            const { latitude, longitude } = geohash.decode(hash)
            const [cx, cy] = projection([longitude, latitude])
            return `<circle cx="${cx}" cy="${cy}" r="${radius}" />`
          })
          .join("")
        return `<g id="${group}" style="fill: var(--${group}-fill, currentColor)" >${circles}</g>`
      })
      .join("")
  }

  return `
    <svg id="points" viewBox="0 0 ${width} ${height}" xmlns="http://www.w3.org/2000/svg">
      ${points}
    </svg>
  `
}

//
// Private functions
// -------------------------------------------------------------------------------------------------

export default async function geoProjection(width, height) {
  const [land] = feature(world, world.objects.land).features
  const projection = geoNaturalEarth1().center([0, 0]).fitSize([width, height], land).rotate([-11.25, 0, 0])

  return { land, projection }
}
