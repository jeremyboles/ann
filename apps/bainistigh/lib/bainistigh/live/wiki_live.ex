defmodule Bainistigh.WikiLive do
  use Bainistigh, :live_view

  import Bainistigh.CommonComponent

  alias __MODULE__.Component
  alias Taifead.Repo
  alias Taifead.Topics

  def handle_info({:draft_created, draft}, socket) do
    socket = update(socket, :catalog, fn catalog -> [draft | catalog] end)
    {:noreply, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    draft = Topics.get_draft!(id) |> Repo.preload(:publications)
    {:noreply, assign(socket, :draft, draft)}
  end

  def handle_params(_params, _uri, socket) do
    IO.inspect("HANDLE")

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
    {:ok, assign(socket, catalog: Topics.list_drafts(), draft: nil)}
  end
end
