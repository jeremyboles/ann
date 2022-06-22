defmodule Bainistigh.JournalLive.ComposeComponent do
  use Bainistigh, :live_component

  alias Taifead.Journal
  alias Taifead.Journal.Entry
  alias Taifead.Topics

  def handle_event("validate", %{"entry" => params}, socket) do
    socket = socket |> assign_changeset(params)
    {:noreply, socket}
  end

  def handle_event("save", %{"action" => "publish", "entry" => params}, socket) do
    {:ok, _entry} = Journal.publish_entry(params)
    {:noreply, push_patch(socket, to: "/journal")}
  end

  def handle_event("save", %{"action" => "save", "entry" => params}, socket) do
    {:ok, _entry} = Journal.create_entry(params)
    {:noreply, push_patch(socket, to: "/journal")}
  end

  def handle_event("update", %{"doc" => doc}, socket) do
    changeset = socket.assigns.changeset |> Ecto.Changeset.change(note: %{doc: doc})
    IO.inspect(changeset, label: "doc")
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("update", %{"coords" => coords, "mapkit_response" => resp}, socket) do
    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_change(:coords, coords)
      |> Ecto.Changeset.put_change(:mapkit_response, resp)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("update", %{"published_at" => published_at}, socket) do
    {:ok, published_at, _} = DateTime.from_iso8601(published_at)
    changeset = socket.assigns.changeset |> Ecto.Changeset.put_change(:published_at, published_at)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("update", %{"tags" => tags}, socket) do
    changeset = Ecto.Changeset.put_change(socket.assigns.changeset, :tags, tags)
    {:noreply, assign(socket, :changeset, changeset)}
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
