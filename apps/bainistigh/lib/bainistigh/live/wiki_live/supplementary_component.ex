defmodule Bainistigh.WikiLive.SupplementaryComponent do
  use Bainistigh, :live_component

  alias Taifead.Topics
  alias Taifead.Topics.Draft

  def handle_event("mark-group-for-deletion", %{"id" => id}, socket) do
    socket = assign(socket, :marked_for_deletion, [id | socket.assigns.marked_for_deletion])
    {:noreply, socket}
  end

  def mount(socket) do
    {:ok, assign(socket, :marked_for_deletion, [])}
  end

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

  defp placeholder(:glossary), do: "e.g. Glossary of Terms"
  defp placeholder(:links), do: "e.g. External Links"
  defp placeholder(%Phoenix.HTML.Form{} = form), do: form |> input_value(:kind) |> placeholder()
  defp placeholder(_), do: nil
end
