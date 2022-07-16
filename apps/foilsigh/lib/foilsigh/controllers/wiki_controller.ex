defmodule Foilsigh.WikiController do
  use Foilsigh, :controller

  alias Taifead.Journal
  alias Taifead.Topics

  def index(conn, _params) do
    topics = Topics.current_publications()
    render(conn, "index.html", topics: topics)
  end

  def recipe(conn, _params), do: render(conn, "recipe.html")

  def show(conn, %{"slug" => slug}) do
    topic = Topics.get_published_by_slug!(slug)
    render(conn, "show.html", [topic: topic] ++ extra_data(topic))
  end

  defp extra_data(%Topics.Publication{} = topic) do
    [
      ancestors: Topics.ancestors(topic),
      descendants: Topics.descendants(topic),
      entries: Journal.list_by_topic(topic),
      from_here: Topics.links_from(topic),
      similar: Topics.with_simpliar_tags(topic),
      to_here: Topics.links_to(topic)
    ]
  end
end
