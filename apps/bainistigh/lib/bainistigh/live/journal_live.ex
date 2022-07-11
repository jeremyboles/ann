defmodule Bainistigh.JournalLive do
  use Bainistigh, :live_view

  import Bainistigh.CommonComponent

  alias Bainistigh.JournalLive.ComposeButtonComponent
  alias Taifead.Journal
  alias Taifead.Journal.Entry

  def handle_info({:entry_created, entry}, socket) do
    socket = update(socket, :entries, fn entries -> [entry | entries] end)
    {:noreply, socket}
  end

  def handle_info({:entry_deleted, entry}, socket) do
    socket = update(socket, :entries, fn e -> Enum.reject(e, &(&1.id == entry.id)) end)
    {:noreply, socket}
  end

  def handle_info({:entry_updated, %Entry{id: id} = entry}, socket) do
    socket = update(socket, :entries, fn c -> replace_when(c, &(&1.id == id), entry) end)
    {:noreply, socket}
  end

  def handle_params(%{"kind" => kind}, _url, %{assigns: %{live_action: :new}} = socket) do
    send_update(ComposeButtonComponent, expanded: false, id: "compose-journal")

    {:noreply, assign(socket, :kind, kind)}
  end

  def handle_params(%{"id" => id}, _url, %{assigns: %{live_action: :show}} = socket) do
    entry = Journal.get_entry!(id)
    {:noreply, assign(socket, :entry, entry)}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, assign(socket, entry: nil, kind: nil)}
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: Journal.subscribe()

    entries = Journal.list_entries()
    {:ok, assign(socket, entries: entries, entry: nil, kind: nil, page_title: "Journal")}
  end

  defp location(%{"muid" => _, "name" => name} = resp) do
    raw("<b>#{name}</b>")
  end

  defp location(%{"administrativeAreaCode" => state, "country" => country, "locality" => city}) do
    raw("<b>#{city}, #{state}, #{country}</b>")
  end

  defp location(%{"country" => country, "locality" => city}) do
    raw("<b>#{city}, #{country}</b>")
  end

  defp location(_) do
    raw("<b><i>Unknown Location</i></b>")
  end

  defp mapkit_url(%{center: %Geo.Point{coordinates: {lng, lat}}} = opts) do
    mapkit_url(%{opts | center: "#{lat},#{lng}"})
  end

  defp mapkit_url(%{center: center} = opts) do
    opts
    |> Map.merge(%{annotations: Jason.encode!([%{point: center}])})
    |> Map.merge(%{scale: "2", size: "480x216", z: 17})
    |> Bainistigh.AppleServices.mapkit_snapshot_url()
  end

  defp published_at(%Journal.Entry{} = entry) do
    entry.published_at
    |> DateTime.shift_zone!(entry.mapkit_response["timezone"])
    |> Calendar.strftime("%d %B %Y · %H:%M")
  end

  defp replace_when(list, fun, value) do
    List.replace_at(list, Enum.find_index(list, fun), value)
  end
end
