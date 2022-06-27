defmodule Bainistigh.JournalLive do
  use Bainistigh, :live_view

  import Bainistigh.CommonComponent

  alias __MODULE__.{Component, ComposeButtonComponent, ComposeComponent, SidebarComponent}
  alias __MODULE__.{EditorComponent, DateComponent, LocationComponent, TagsComponent}
  alias Bainistigh.MapKit
  alias Taifead.Journal

  def handle_event("show", %{"id" => id}, socket) do
    IO.inspect(id, label: "show")
    {:noreply, socket}
  end

  def handle_info({:entry_created, entry}, socket) do
    socket = update(socket, :entries, fn entries -> [entry | entries] end)
    {:noreply, socket}
  end

  def handle_params(%{"kind" => kind}, _url, %{assigns: %{live_action: :new}} = socket) do
    send_update(ComposeButtonComponent, expanded: false, id: "compose-journal")
    {:noreply, assign(socket, :kind, kind)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, assign(socket, :kind, nil)}
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: Journal.subscribe()

    entries = Journal.list_entries()
    {:ok, assign(socket, entries: entries, entry: nil, kind: nil, page_title: "Journal")}
  end

  defp mapkit_url(%{center: center} = opts) do
    opts
    |> Map.merge(%{annotations: Jason.encode!([%{point: center}])})
    |> Map.merge(%{scale: "2", size: "480x216", z: 17})
    |> MapKit.snapshot_url()
  end
end
