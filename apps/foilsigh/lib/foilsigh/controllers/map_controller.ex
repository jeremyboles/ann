defmodule Foilsigh.MapController do
  use Foilsigh, :controller

  def index(conn, _params) do
    points =
      Taifead.Journal.locations(1)
      |> Enum.concat(Taifead.Topics.locations(1))
      |> Enum.uniq_by(&geohash/1)

    locations =
      (Taifead.Journal.list_published_entries() ++ Taifead.Topics.list_publications())
      |> Enum.group_by(&group_by_country/1)
      |> Enum.map(&map_countries/1)

    IO.inspect(Enum.count(locations))

    render(conn, "index.html", locations: locations, points: points)
  end

  def city_name(%{"country" => "Ireland", "locality" => "Dublin" <> _}) do
    "Dublin"
  end

  def city_name(%{"country" => "United States"} = resp) do
    ~s(#{resp["locality"]}, #{resp["administrativeAreaCode"]})
  end

  def city_name(%{"locality" => city}), do: city

  defp geohash(coords), do: Foilsigh.Geo.to_geohash_string(coords, 5)

  defp group_by_city(%{mapkit_response: resp}), do: city_name(resp)

  defp group_by_country(%{mapkit_response: %{"country" => country}}), do: country

  defp map_cities({city, items}) do
    {city, {Enum.count(items), geohash(hd(items).coords)}}
  end

  defp map_countries({country, items}) do
    items = Enum.group_by(items, &group_by_city/1) |> Enum.map(&map_cities/1)
    {country, items}
  end
end
