defmodule Bainistigh.JournalLive do
  use Bainistigh, :live_view

  import Bainistigh.CommonComponent

  alias __MODULE__.{Component, ComposeButtonComponent, ComposeComponent}
  alias Bainistigh.MapKit

  def handle_event("close-compose", _params, socket) do
    {:noreply, push_event(socket, "close-dialog", %{})}
  end

  def handle_event("open-compose", %{"kind" => kind}, socket) do
    {:ok, entry} = Taifead.Journal.create_entry(%{kind: kind})

    send_update(ComposeButtonComponent, expanded: false, id: "compose-journal")
    {:noreply, socket |> push_event("open-dialog", %{}) |> assign(:entry, entry)}
  end

  def handle_params(_params, _url, socket), do: {:noreply, socket}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, entry: nil, page_title: "Journal")}
  end

  defp mapkit_url(%{center: center} = opts) do
    opts
    |> Map.merge(%{annotations: Jason.encode!([%{point: center}])})
    |> Map.merge(%{scale: "2", size: "480x216", z: 17})
    |> MapKit.snapshot_url()
  end
end
