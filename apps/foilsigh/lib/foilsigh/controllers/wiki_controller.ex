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

    entries = Journal.list_by_topic(topic)

    ancestors = Topics.ancestors(topic)
    descendants = Topics.descendants(topic)
    from_here = Topics.links_from(topic)
    similar = Topics.with_simpliar_tags(topic)
    to_here = Topics.links_to(topic)

    render(conn, "show.html",
      ancestors: ancestors,
      descendants: descendants,
      entries: entries,
      from_here: from_here,
      similar: similar,
      to_here: to_here,
      topic: topic
    )
  end
end
