defmodule Bainistigh.JournalLive.ComposeComponent do
  use Bainistigh, :live_component

  alias Bainistigh.JournalLive.SidebarComponent

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns) |> assign_changeset()}
  end

  def handle_event("publish", _params, socket) do
    IO.inspect("publish")
    {:noreply, push_event(socket, "close-dialog", %{})}
  end

  def handle_event("save", _params, socket) do
    IO.inspect("save")
    {:noreply, push_event(socket, "close-dialog", %{})}
  end

  defp assign_changeset(%{assigns: %{entry: nil}} = socket) do
    assign(socket, :changeset, nil)
  end

  defp assign_changeset(%{assigns: %{entry: entry}} = socket) do
    assign(socket, :changeset, Taifead.Journal.change_entry(entry))
  end
end
