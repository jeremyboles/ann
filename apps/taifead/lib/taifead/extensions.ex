# Adds all of the custom types that make working with PostGIS, LTree, and Ecto more pleasant
Postgrex.Types.define(
  Taifead.PostgresTypes,
  [
    Geo.PostGIS.Extension,
    Hierarch.Postgrex.Extensions.LQuery,
    Hierarch.Postgrex.Extensions.LTree
  ] ++ Ecto.Adapters.Postgres.extensions(),
  json: Jason
)
