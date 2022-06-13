defmodule Foilsigh.WikiComponent do
  use Foilsigh, :component

  alias Taifead.Topics.Publication
  alias Taifead.Wiki.Article

  def nested_list(assigns) do
    ~H"""
      <ul class="nested_list">
        <%= for topic <- children_of(@topics) do %>
          <.topic_item topic={topic} topics={@topics} />
        <% end %>
      </ul>
    """
  end

  defp topic_item(assigns) do
    path = Hierarch.LTree.concat(assigns.topic.path, assigns.topic.id)
    assigns = assign(assigns, children: children_of(assigns.topics, path))

    ~H"""
      <li>
          <a href={"/#{@topic.url_slug}"}><%= title(@topic)%></a>
          <%= if Enum.count(@children) > 0 do %>
            <ul>
              <%= for topic <- @children do %>
                <.topic_item topic={topic} topics={@topics} />
              <% end %>
            </ul>
          <% end %>
      </li>
    """
  end

  defp children_of(topics, path \\ "") do
    topics |> Enum.filter(&(&1.path == path)) |> Enum.sort_by(&title/1)
  end

  defp title(%Publication{short_title: short_title, title_text: title_text}) do
    short_title || title_text
  end
end
