defmodule Bainistigh.WikiLive.HistoryComponent do
  use Bainistigh, :live_component

  alias Taifead.Wiki.ArticleRevision

  def render(assigns) do
    ~H"""
      <section class="HistoryComponent" role="tabpanel">
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
                <tr>
                  <td><%= Date.to_string(revision.updated_at) %></td>
                  <td><%= location revision %></td>
                </tr>
              <% end %>
            <% else %>
              <tr><td colspan="2" /></tr>
            <% end %>
          </tbody>
        </table>
        
        <div class="preview">
          This section will contain the <i>revision preview</i>.
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
