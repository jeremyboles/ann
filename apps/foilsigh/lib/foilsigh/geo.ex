defmodule Foilsigh.Geo do
  import Geocalc

  alias Geocalc.Shape.Circle

  def obfuscate_point(%Geo.Point{} = point) do
    case translate_to(point) do
      {_, to} -> to
      _ -> point
    end
  end

  def round_point(%Geo.Point{coordinates: {lat, lng}}, precision \\ 4) do
    %Geo.Point{coordinates: {Float.round(lat, precision), Float.round(lng, precision)}}
  end

  def to_decimal_string(%Geo.Point{} = point) do
    %Geo.Point{coordinates: {lat, lng}} = round_point(point) |> obfuscate_point()
    "#{lat} #{lng}"
  end

  def to_dms_string(%Geo.Point{} = point) do
    %Geo.Point{coordinates: {lat, lng}} = round_point(point) |> obfuscate_point()
    "#{decimal_to_lat_dms(lat)} #{decimal_to_lng_dms(lng)}"
  end

  def to_geohash_string(%Geo.Point{} = point, precision \\ 9) do
    %Geo.Point{coordinates: {lat, lng}} = round_point(point) |> obfuscate_point()
    Geohash.encode(lat, lng, precision)
  end

  defp decimal_to_dms(decimal, direction) do
    "#{degrees(decimal)}°#{minutes(decimal)}'#{seconds(decimal)}\"#{direction}"
  end

  defp decimal_to_lat_dms(decimal) when decimal > 0, do: decimal_to_dms(decimal, "N")
  defp decimal_to_lat_dms(decimal) when decimal < 0, do: decimal_to_dms(decimal, "S")

  defp decimal_to_lng_dms(decimal) when decimal > 0, do: decimal_to_dms(decimal, "E")
  defp decimal_to_lng_dms(decimal) when decimal < 0, do: decimal_to_dms(decimal, "W")

  defp degrees(decimal) do
    decimal
    |> Kernel.abs()
    |> Float.floor()
    |> Kernel.trunc()
  end

  # TODO: figure out how to calculate this at build or boot time
  def from_env() do
    Application.get_env(:foilsigh, __MODULE__, [])
    |> Keyword.get(:translate_coords, "")
    |> String.split(",")
    |> Enum.map(&parse_pair/1)
    |> Enum.reject(&is_nil/1)
  end

  defp minutes(decimal) do
    ((Kernel.abs(decimal) - degrees(decimal)) * 60)
    |> Float.floor()
    |> Kernel.trunc()
  end

  defp parse_pair(pair) when is_binary(pair), do: pair |> String.split(":") |> parse_pair()
  defp parse_pair([from | [to | _]]), do: {to_circle(from), to_point(to)}
  defp parse_pair(_), do: nil

  defp seconds(decimal) do
    (((Kernel.abs(decimal) - degrees(decimal)) * 60 - minutes(decimal)) * 60)
    |> Decimal.from_float()
    |> Decimal.round(1)
  end

  def to_circle(hash) when is_binary(hash), do: hash |> Geohash.decode() |> to_circle()
  def to_circle({lat, lng}), do: %Circle{latitude: lat, longitude: lng, radius: 150}

  def to_point(hash) when is_binary(hash), do: hash |> Geohash.decode() |> to_point()
  def to_point({lat, lng}), do: %Geo.Point{coordinates: {lat, lng}}

  defp translate_to(%Geo.Point{coordinates: {lat, lng}}) do
    from_env() |> Enum.find(fn {from, _to} -> in_area?(from, %{lat: lat, lng: lng}) end)
  end
end
