defmodule Foilsigh.EssaysComponent do
  use Foilsigh, :component

  def essay_summary(%{inner_block: _} = assigns) do
    ~H"""
      <article class="essay_summary">
        <figure>
          <a href="/essays/show">
            <picture>
              <img alt="" loading="lazy" height="837" src="http://localhost:4000/images/avatar@880w.webp" width="1256">
            </picture>
          </a>
        </figure>
      
        <h3><a href="/essays/show"><%= @title %></a></h3>
        <%= if @inner_block do %>
          <p>This is the summary of the article and it's only about a sentence long. But, in theory, could be longer than that. It just depends on the essay, I guess.</p>
        <% end %>
      
        <aside>
          <p>
            <span>This piece of writing was posted under the topic “</span><a href="/topic">Topic Title</a><span>” on</span>
            <time datetime="2021-10-26">October 26<span>th</span>,&nbsp;2021</time><span>.</span>
          </p>
        </aside>
      </article>
    """
  end

  def essay_summary(assigns) do
    essay_summary(assign(assigns, :inner_block, false))
  end
end
