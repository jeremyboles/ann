defmodule Foilsigh.MapController do
  use Foilsigh, :controller

  alias Taifead.{Geo, Journal, Topics}

  def index(conn, _params) do
    points = (Journal.locations(1) ++ Topics.locations(1)) |> Enum.uniq_by(&geohash/1)

    locations =
      (Journal.list_published_entries() ++ Topics.list_publications())
      |> Enum.group_by(&group_by_country/1)
      |> Enum.map(&map_countries/1)

    IO.inspect(Enum.count(locations))

    render(conn, "index.html", locations: locations, points: points)
  end

  defp geohash(coords), do: Foilsigh.Geo.to_geohash_string(coords, 5)

  defp group_by_city(%{mapkit_response: resp}), do: Geo.city_name(resp)

  defp group_by_country(%{mapkit_response: %{"country" => country}}), do: country

  defp map_cities({city, items}) do
    {city, {Enum.count(items), geohash(hd(items).coords)}}
  end

  defp map_countries({country, items}) do
    items = Enum.group_by(items, &group_by_city/1) |> Enum.map(&map_cities/1)
    {country, items}
  end
end
