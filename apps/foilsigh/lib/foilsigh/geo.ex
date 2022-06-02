defmodule Foilsigh.Geo do
  def round_point(%Geo.Point{coordinates: {lat, lng}}, precision \\ 4) do
    %Geo.Point{coordinates: {Float.round(lat, precision), Float.round(lng, precision)}}
  end

  def to_decimal_string(%Geo.Point{} = point) do
    %Geo.Point{coordinates: {lat, lng}} = round_point(point)
    "#{lat} #{lng}"
  end

  def to_dms_string(%Geo.Point{} = point) do
    %Geo.Point{coordinates: {lat, lng}} = round_point(point)
    "#{decimal_to_lat_dms(lat)} #{decimal_to_lng_dms(lng)}"
  end

  def to_geohash_string(%Geo.Point{} = point, precision \\ 9) do
    %Geo.Point{coordinates: {lat, lng}} = round_point(point)
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
