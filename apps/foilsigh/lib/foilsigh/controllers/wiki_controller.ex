defmodule Foilsigh.WikiController do
  use Foilsigh, :controller

  alias Taifead.Topics

  def index(conn, _params) do
    topics = Topics.current_publications()
    render(conn, "index.html", topics: topics)
  end

  def recipe(conn, _params), do: render(conn, "recipe.html")

  def show(conn, %{"slug" => slug}) do
    topic = Topics.get_published!(slug)
    ancestors = []

    render(conn, "show.html", ancestors: ancestors, topic: topic)
  end
end
