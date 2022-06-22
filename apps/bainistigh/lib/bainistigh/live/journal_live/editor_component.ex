defmodule Bainistigh.JournalLive.EditorComponent do
  use Bainistigh, :live_component

  defp json(nil), do: ""
  defp json(map), do: Jason.encode!(map)
end
