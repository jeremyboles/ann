defmodule Bainistigh.WikiComponent do
  use Bainistigh, :component

  def article_header(assigns) do
    ~H"""
      <div class="article_header">
        <h1><%= render_slot(@inner_block) %></h1>
        <p>Recipe-Style Topic</p>
      </div>
    """
  end

  def public_toggle(assigns) do
    ~H"""
      <label class="public_toggle">
        <input type="checkbox" />
        <span><%= render_slot(@inner_block) %></span>
      </label>
    """
  end

  def save_button(assigns) do
    ~H"""
      <div class="save_button">
        <button>Save</button>
        <input form="none" type="checkbox"/>
        <div class="options">
          <button>Save Over Current Revision</button>
        </div>
      </div>
    """
  end

  def sidebar(assigns) do
    ~H"""
      <aside class="sidebar">
        <.search />
        <.tabs />
        <.article_list />
      </aside>
    """
  end

  defp article_list(assigns) do
    ~H"""
      <div class="article_list">
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
          <input form="none" type="checkbox"/>
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
       <input placeholder="Search Wiki Articles" type="search">
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
