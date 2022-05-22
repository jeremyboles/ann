defmodule Bainistigh.WikiLive.CatalogComponent do
  use Bainistigh, :live_component

  def render(assigns) do
    ~H"""
      <aside class="CatalogComponent">
        <.search />
        <.tabs />
        <.list />
      </aside>
    """
  end

  defp list(assigns) do
    ~H"""
    <div class="list">
      <.new_article_button />
      <ul>
        <li>Article List</li>
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
