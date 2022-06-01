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

  def render(assigns) do
    ~H"""
      <section class="HistoryComponent" role="tabpanel">
        <div class="history">
          <table>
            <thead>
              <tr>
                <th>Date</th>
                <th>Location</th>
              </tr>
            </thead>
            <tbody>
              <%= if @article do %>
                <%= for revision <- @article.revisions do %>
                <tr aria-selected={if @selected && @selected.id == revision.id, do: "true"} phx-click="select" phx-target={@myself} phx-value-id={revision.id}>
                    <td><%= Date.to_string(revision.updated_at) %></td>
                    <td><%= location revision %></td>
                  </tr>
                <% end %>
              <% else %>
                <tr><td colspan="2" /></tr>
              <% end %>
            </tbody>
          </table>
        </div>
        
        <div class="preview">
          <%= if @selected do %>
            <%= raw @selected.content_html %>
          <% end %>
        </div>
      </section>
    """
  end

  defp location(%ArticleRevision{mapkit_response: []}) do
    raw("<i>Unknown</i>")
  end

  defp location(%ArticleRevision{mapkit_response: %{"results" => [result | _]}}) do
    case result do
      %{"administrativeAreaCode" => state, "country" => "United States", "locality" => city} ->
        "#{city}, #{state}"

      _ ->
        raw("<i>Unknown</i>")
    end
  end
end
