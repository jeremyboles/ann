defmodule Foilsigh.EssaysComponent do
  use Foilsigh, :component

  def essay_summary(%{featured: true, inner_block: _} = assigns) do
    ~H"""
      <article class="essay_summary featured">
        <a href="/essays/show">
          <.essay_summary_figure />
          <h2><%= @title %></h2>
        </a>
        <p><%= render_slot(@inner_block) %></p>
        <.essay_summary_meta date />
      </article>
    """
  end

  def essay_summary(assigns) do
    ~H"""
      <article class="essay_summary">
        <a href="/essays/show">
          <.essay_summary_figure />
          <h2><%= @title %></h2>
        </a>
        <.essay_summary_meta />
      </article>
    """
  end

  def essay_summary_figure(assigns) do
    ~H"""
      <figure>
        <picture>
          <img alt="" loading="lazy" height="837" src="https://imagedelivery.net/Wfox5u9ZjFI2UCRBV0RBtA/fcfe1709-5c58-499d-cc25-90b26661fc00/public" width="1256">
        </picture>
      </figure>
    """
  end

  def essay_summary_meta(%{date: _} = assigns) do
    ~H"""
      <aside>
        <p>
          <span class="vh">This piece of writing was posted under the topic “</span><a href="/topic">Topic Title</a><span class="vh">” on</span>
          <time datetime="2021-10-26">October 26<span>th</span>,&nbsp;2021</time><span class="vh">.</span>
        </p>
      </aside>
    """
  end

  def essay_summary_meta(assigns) do
    ~H"""
      <aside>
        <p>
          <span class="vh">This piece of writing was posted under the topic “</span><a href="/topic">Topic Title</a><span class="vh">.</span>
        </p>
      </aside>
    """
  end
end
