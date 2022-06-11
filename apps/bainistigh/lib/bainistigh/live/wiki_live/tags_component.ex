defmodule Bainistigh.WikiLive.TagsComponent do
  use Bainistigh, :live_component

  alias Ecto.Changeset
  alias Taifead.Topics

  def handle_event("add-tag", _params, %{assigns: %{changeset: changeset, index: nil}} = socket) do
    tags = ["" | Changeset.fetch_field!(changeset, :tags)]
    changeset = Changeset.put_change(changeset, :tags, tags)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("add-tag", _params, %{assigns: %{changeset: changeset, index: index}} = socket) do
    tags = changeset |> Changeset.fetch_field!(:tags) |> List.insert_at(index + 1, "")
    changeset = Changeset.put_change(changeset, :tags, tags)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("input-focus", %{"index" => index}, socket) do
    {index, _} = Integer.parse(index)
    {:noreply, assign(socket, :index, index)}
  end

  def handle_event("update", %{"draft" => params}, %{assigns: %{draft: draft}} = socket) do
    {:ok, _draft} = Topics.update_draft(draft, params)
    {:noreply, socket}
  end

  def update(assigns, socket) do
    IO.inspect("UPDATE")
    socket = socket |> assign(assigns) |> assign(index: nil) |> assign_changeset()
    {:ok, socket}
  end

  defp assign_changeset(%{assigns: %{draft: draft}} = socket) do
    socket |> assign(:changeset, Topics.change_draft(draft))
  end
end
