defmodule Bainistigh.WikiLive.HistoryComponent do
  use Bainistigh, :live_component

  alias Taifead.Wiki.ArticleRevision

  def handle_event("select", %{"id" => id}, socket) do
    selected = socket.assigns.article.revisions |> Enum.find(&(&1.id == id))
    {:noreply, assign(socket, :selected, selected)}
  end

  def mount(socket) do
    {:ok, assign(socket, :selected, nil)}
  end

  def update(assigns, socket) do
    socket = socket |> assign(assigns) |> assign(:selected, nil)
    {:ok, socket}
  end

  defp location(%ArticleRevision{mapkit_response: %{"results" => [result | _]}}) do
    case result do
      %{"administrativeAreaCode" => state, "country" => "United States", "locality" => city} ->
        "#{city}, #{state}"

      _ ->
        raw("<i>Unknown</i>")
    end
  end

  defp location(_) do
    raw("<i>Unknown</i>")
  end
end
