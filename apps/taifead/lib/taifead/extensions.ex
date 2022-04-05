# Adds all of the custom types that make working with PostGIS and Ecto more plesant
Postgrex.Types.define(
  Taifead.PostgresTypes,
  [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
  json: Jason
)
