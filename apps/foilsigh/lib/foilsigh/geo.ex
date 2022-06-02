defmodule Foilsigh.Geo do
  import Geocalc

  alias Geocalc.Shape.Circle

  # TODO: move this ugly bit into some macros
  @translate (Application.get_env(:foilsigh, __MODULE__) || [])
             |> Keyword.get(:translate_coords, "")
             |> String.split(",")
             |> Enum.map(fn str ->
               case String.split(str, ":") do
                 [from | [to | _]] ->
                   {from_lat, from_lng} = Geohash.decode(from)
                   {to_lat, to_lng} = Geohash.decode(to)

                   {%Circle{latitude: from_lat, longitude: from_lng, radius: 150},
                    %Geo.Point{coordinates: {to_lat, to_lng}}}

                 _ ->
                   nil
               end
             end)
             |> Enum.reject(&is_nil/1)

  def obfuscate_point(%Geo.Point{coordinates: {lat, lng}} = point) do
    case Enum.find(@translate, fn {from, _to} -> in_area?(from, %{lat: lat, lng: lng}) end) do
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

  defp minutes(decimal) do
    ((Kernel.abs(decimal) - degrees(decimal)) * 60)
    |> Float.floor()
    |> Kernel.trunc()
  end

  defp seconds(decimal) do
    (((Kernel.abs(decimal) - degrees(decimal)) * 60 - minutes(decimal)) * 60)
    |> Decimal.from_float()
    |> Decimal.round(1)
  end
end
