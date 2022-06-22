defmodule Bainistigh.JournalLive.LocationComponent do
  use Bainistigh, :live_component

  defp hidden_coords_input(form) do
    case input_value(form, :coords) do
      nil ->
        hidden_input(form, :coords)

      "" ->
        hidden_input(form, :coords)

      %{"latitude" => lat, "longitude" => lng} ->
        hidden_input(form, :coords, value: "#{lat} #{lng}")

      %Geo.Point{coordinates: {lat, lng}} ->
        hidden_input(form, :coords, value: "#{lat} #{lng}")
    end
  end

  defp hidden_mapkit_response_input(form) do
    case input_value(form, :mapkit_response) do
      nil ->
        hidden_input(form, :mapkit_response)

      "" ->
        hidden_input(form, :mapkit_response)

      data ->
        hidden_input(form, :mapkit_response, value: Jason.encode!(data))
    end
  end
end
