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

  defp article_li(assigns) do
    current =
      if Map.get(assigns.current, :id, nil) === Map.get(assigns.article, :id) do
        'page'
      else
        false
      end

    ~H"""
    <li>
      <%= live_patch 'aria-current': current, to: "/wiki/#{@article.id}" do %>
        <%= raw @article.title_html %>
      <% end %>
    </li>
    """
  end

  defp list(assigns) do
    ~H"""
    <div class="list">
      <.new_article_button />
      <ul>
        <%= for article <- @articles do %>
          <.article_li current={@current} article={article} />
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
        <button accesskey="q">Quick Topic</button>
        <button accesskey="l">Long-Form Topic</button>
        <button accesskey="r">Recipe-Type Topic</button>
      </div>
    </div>
    """
  end

  defp search(assigns) do
    ~H"""
    <form class="search">
      <input placeholder="Search Wiki Articles" type="search" />
    </form>
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
