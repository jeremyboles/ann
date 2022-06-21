defmodule Bainistigh.JournalLive.ComposeComponent do
  use Bainistigh, :live_component

  alias Taifead.Journal
  alias Taifead.Journal.Entry
  alias Taifead.Topics

  def handle_event("validate", %{"entry" => params}, socket) do
    socket = socket |> assign_changeset(params)
    {:noreply, socket}
  end

  def handle_event("save", %{"action" => "save", "entry" => params}, socket) do
    {:ok, _entry} = Journal.create_entry(params)
    {:noreply, push_patch(socket, to: "/journal")}
  end

  def handle_event("update", params, socket) do
    socket = socket |> assign_changeset(params)
    {:noreply, socket}
  end

  def mount(socket) do
    topics = Topics.list_drafts()
    {:ok, assign(socket, entry: nil, topics: topics)}
  end

  def update(assigns, socket) do
    socket = socket |> assign(assigns) |> assign_changeset()
    {:ok, socket}
  end

  defp assign_changeset(socket, attrs \\ %{})

  defp assign_changeset(%{assigns: %{entry: nil}} = socket, attrs) do
    assign(socket, :changeset, Journal.change_entry(%Entry{}, attrs))
  end

  defp assign_changeset(%{assigns: %{entry: entry}} = socket, attrs) do
    assign(socket, :changeset, Journal.change_entry(entry, attrs))
  end
end
