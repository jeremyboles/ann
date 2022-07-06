defmodule Bainistigh.WikiLive.HistoryComponent do
  use Bainistigh, :live_component

  alias Taifead.Topics.Publication

  def handle_event("select", %{"id" => id}, socket) do
    selected = socket.assigns.draft.publications |> Enum.find(&(&1.id == id))
    {:noreply, assign(socket, :selected, selected)}
  end

  def mount(socket) do
    {:ok, assign(socket, :selected, nil)}
  end

  def update(assigns, socket) do
    socket = socket |> assign(assigns) |> assign(:selected, nil)
    {:ok, socket}
  end

  defp location(%Publication{mapkit_response: response}) do
    case response do
      %{"administrativeAreaCode" => state, "country" => "United States", "locality" => city} ->
        "#{city}, #{state}"

      %{"country" => country, "locality" => city} ->
        "#{city}, #{country}"

      _ ->
        raw("<i>Unknown</i>")
    end
  end

  defp location(_) do
    raw("<i>Unknown</i>")
  end
end
