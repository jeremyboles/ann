defmodule Foilsigh.WikiComponent do
  use Foilsigh, :component

  alias Taifead.Wiki.Article

  def nested_list(assigns) do
    ~H"""
      <ul class="nested_list">
        <%= for article <- children_of(@articles) do %>
          <.article_item article={article} articles={@articles} />
        <% end %>
      </ul>
    """
  end

  defp article_item(assigns) do
    path = Hierarch.LTree.concat(assigns.article.path, assigns.article.id)
    assigns = assign(assigns, children: children_of(assigns.articles, path))

    ~H"""
      <li>
          <a href={"/#{@article.url_slug}"}><%= title(@article)%></a>
          <%= if Enum.count(@children) > 0 do %>
            <ul>
              <%= for article <- @children do %>
                <.article_item article={article} articles={@articles} />
              <% end %>
            </ul>
          <% end %>
      </li>
    """
  end

  defp children_of(articles, path \\ "") do
    articles |> Enum.filter(&(&1.path == path)) |> Enum.sort_by(&title/1)
  end

  defp title(%Article{short_title: short_title, title_text: title_text}) do
    short_title || title_text
  end
end
