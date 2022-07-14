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
    ancestors = Topics.ancestors(topic)
    entries = Journal.list_by_topic(topic)

    render(conn, "show.html", ancestors: ancestors, entries: entries, topic: topic)
  end
end
