defmodule Bainistigh.JournalLive.MetaComponent do
  use Bainistigh, :live_component

  defp conditions(form) do
    case form |> weather() |> Map.get("conditionCode") do
      "MostlyClear" -> "Mostly Clear"
      "MostlyCloudy" -> "Mostly Cloudy"
      condition -> condition
    end
  end

  defp daylight(form) do
    form |> weather() |> Map.get("daylight")
  end

  defp temperature(form) do
    form |> weather() |> Map.get("temperature")
  end

  defp weather(form) do
    form |> input_value(:weatherkit_response) |> Map.get("currentWeather", %{})
  end
end
