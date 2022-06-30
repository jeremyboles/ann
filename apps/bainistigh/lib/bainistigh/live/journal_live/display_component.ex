defmodule Bainistigh.JournalLive.DisplayComponent do
  use Bainistigh, :live_component

  alias Taifead.Journal
  alias Taifead.Journal.Entry

  def handle_event("delete", _params, %{assigns: %{entry: entry}} = socket) do
    {:ok, _entry} = Journal.delete_entry(entry)
    {:noreply, push_patch(socket, to: "/journal")}
  end

  def update(assigns, socket) do
    {:ok, socket = socket |> assign(assigns) |> assign_changeset()}
  end

  defp assign_changeset(socket, attrs \\ %{})

  defp assign_changeset(%{assigns: %{entry: nil, kind: kind}} = socket, attrs) do
    assign(socket, :changeset, Journal.change_entry(%Entry{kind: kind}, attrs))
  end

  defp assign_changeset(%{assigns: %{entry: entry}} = socket, attrs) do
    assign(socket, :changeset, Journal.change_entry(entry, attrs))
  end
end
