defmodule Bainistigh.JournalLive.CheckinComponent do
  use Bainistigh, :live_component

  defp hidden_coords_input(form) do
    case input_value(form, :coords) do
      nil ->
        hidden_input(form, :coords)

      "" ->
        hidden_input(form, :coords)

      %{"latitude" => lat, "longitude" => lng} ->
        value = %Geo.Point{coordinates: {lng, lat}, srid: nil} |> Jason.encode!()
        hidden_input(form, :coords, value: value)

      %Geo.Point{} = geom ->
        hidden_input(form, :coords, value: Jason.encode!(geom))
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

  defp hidden_weatherkit_response_input(form) do
    case input_value(form, :weatherkit_response) do
      nil ->
        hidden_input(form, :weatherkit_response)

      "" ->
        hidden_input(form, :weatherkit_response)

      data ->
        hidden_input(form, :weatherkit_response, value: Jason.encode!(data))
    end
  end
end
