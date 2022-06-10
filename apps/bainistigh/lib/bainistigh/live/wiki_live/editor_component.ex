defmodule Bainistigh.WikiLive.EditorComponent do
  use Bainistigh, :live_component

  alias Taifead.Topics
  alias Taifead.Topics.Draft

  def update(assigns, socket) do
    socket = socket |> assign(assigns) |> assign_draft() |> assign_changeset()
    {:ok, socket}
  end

  defp assign_draft(socket) do
    socket |> assign(:draft, %Draft{})
  end

  defp assign_changeset(%{assigns: %{draft: draft}} = socket) do
    socket |> assign(:changeset, Topics.change_draft(draft))
  end

  defp json(nil), do: ""
  defp json(map), do: Jason.encode!(map)
end
