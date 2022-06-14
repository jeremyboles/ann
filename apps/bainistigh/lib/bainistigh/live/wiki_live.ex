defmodule Bainistigh.WikiLive do
  use Bainistigh, :live_view

  import Bainistigh.CommonComponent

  alias __MODULE__.Component
  alias Taifead.Repo
  alias Taifead.Topics
  alias Taifead.Topics.Draft

  def handle_event("get-last-location", _params, socket) do
    %{coords: %{coordinates: {lat, lng}}} = Topics.latest_publication()
    {:noreply, push_event(socket, "last-location-found", %{latitude: lat, longitude: lng})}
  end

  def handle_event("publish", _params, %{assigns: %{draft: draft, location: location}} = socket) do
    {:ok, _draft} = Topics.publish(draft, location)
    {:noreply, socket}
  end

  def handle_event("request-location", _parans, socket) do
    {:noreply, push_event(socket, "request-location", %{})}
  end

  def handle_event("update-location", location, socket) do
    {:noreply, assign(socket, :location, location)}
  end

  def handle_info({:draft_created, draft}, socket) do
    socket = update(socket, :catalog, fn catalog -> [draft | catalog] end)
    {:noreply, socket}
  end

  def handle_info({:draft_updated, %Draft{id: id} = draft}, socket) do
    socket = update(socket, :catalog, fn c -> replace_when(c, &(&1.id == id), draft) end)
    socket = if socket.assigns.draft.id == id, do: assign(socket, :draft, draft), else: socket
    {:noreply, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    draft = Topics.get_draft!(id) |> Repo.preload(:publications)
    {:noreply, assign(socket, :draft, draft)}
  end

  def handle_params(_params, _uri, socket) do
    case Topics.latest_draft() do
      nil ->
        {:ok, draft} = Topics.create_draft()
        {:noreply, push_patch(socket, to: "/wiki/#{draft.id}")}

      %Topics.Draft{} = draft ->
        {:noreply, push_patch(socket, to: "/wiki/#{draft.id}")}
    end
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: Topics.subscribe()

    {:ok, assign(socket, catalog: Topics.list_drafts(), draft: nil, location: nil)}
  end

  defp replace_when(list, fun, value) do
    List.replace_at(list, Enum.find_index(list, fun), value)
  end
end
