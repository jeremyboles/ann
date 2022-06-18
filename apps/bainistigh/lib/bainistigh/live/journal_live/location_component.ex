defmodule Bainistigh.JournalLive.LocationComponent do
  use Bainistigh, :live_component

  alias Taifead.Journal

  def handle_event("update", attrs, %{assigns: %{entry: entry}} = socket) do
    {:ok, _entry} = Journal.update_entry(entry, attrs)
    {:noreply, socket}
  end

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns) |> assign_changeset()}
  end

  defp assign_changeset(%{assigns: %{entry: entry}} = socket) do
    assign(socket, :changeset, Taifead.Journal.change_entry(entry))
  end
end
