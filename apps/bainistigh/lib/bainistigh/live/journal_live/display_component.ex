defmodule Bainistigh.JournalLive.DisplayComponent do
  use Bainistigh, :live_component

  alias Taifead.Journal

  def handle_event("delete", _params, %{assigns: %{entry: entry}} = socket) do
    {:ok, _entry} = Journal.delete_entry(entry)
    {:noreply, push_patch(socket, to: "/journal")}
  end
end
