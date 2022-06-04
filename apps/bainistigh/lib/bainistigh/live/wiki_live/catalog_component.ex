defmodule Bainistigh.WikiLive.CatalogComponent do
  use Bainistigh, :live_component

  alias Taifead.Wiki

  def mount(socket) do
    socket = assign(socket, :articles, Wiki.ordered_articles())
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <aside class="CatalogComponent">
        <.search />
        <.tabs />
        <.list articles={@articles} current={@current} />
      </aside>
    """
  end

  @doc """
  For setting the value of the `aria-current` attribute to `"page"`, if the given article
  matches the current one.
  """
  defp aria_current(%{id: id}, %{id: id}), do: 'page'
  defp aria_current(_article, _current), do: false

  defp article_li(assigns) do
    path = Hierarch.LTree.concat(assigns.article.path, assigns.article.id)
    children = children_of(assigns.articles, path)

    ~H"""
    <li>
      <%= live_patch 'aria-current': aria_current(@article, @current), to: "/wiki/#{@article.id}" do %>
        <%= raw @article.title_html %>
      <% end %>

      <%= if Enum.count(children) > 0 do %>
        <ul>
          <%= for article <- children do %>
            <.article_li article={article} articles={@articles} current={@current} />
          <% end %>
        </ul>
      <% end %>
    </li>
    """
  end

  defp children_of(articles, path \\ "") do
    articles |> Enum.filter(&(&1.path == path)) |> Enum.sort_by(&{&1.title_text})
  end

  defp list(assigns) do
    ~H"""
    <div class="list">
      <.new_article_button />
      <ul>
        <%= for article <- children_of(@articles) do %>
          <.article_li current={@current} article={article} articles={@articles} />
        <% end %>
      </ul>
    </div>
    """
  end

  defp new_article_button(assigns) do
    ~H"""
    <div class="new_article_button">
      <label>
        <span>New Article</span>
        <input form="none" type="checkbox" />
      </label>
      <div class="options">
        <button accesskey="w">Wiki-Style Topic</button>
        <button accesskey="r">Recipe-Style Topic</button>
      </div>
    </div>
    """
  end

  defp search(assigns) do
    ~H"""
    <div class="search">
      <input placeholder="Search Wiki Articles" type="search" />
    </div>
    """
  end

  defp tabs(assigns) do
    ~H"""
    <ul class="tabs">
      <li class="selected">All</li>
      <li>New</li>
      <li>Recent</li>
    </ul>
    """
  end
end
