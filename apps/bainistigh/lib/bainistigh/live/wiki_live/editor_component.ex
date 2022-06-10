defmodule Bainistigh.WikiLive.EditorComponent do
  use Bainistigh, :live_component

  alias Taifead.Topics

  def handle_event("update-doc", doc, %{assigns: %{draft: draft}} = socket) do
    {:ok, _draft} = Topics.update_draft(draft, %{"doc" => doc})
    {:noreply, socket}
  end

  def update(assigns, socket) do
    socket = socket |> assign(assigns) |> assign_changeset()
    {:ok, socket}
  end

  defp assign_changeset(%{assigns: %{draft: draft}} = socket) do
    socket |> assign(:changeset, Topics.change_draft(draft))
  end

  defp json(nil), do: ""
  defp json(map), do: Jason.encode!(map)
end
