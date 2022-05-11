defmodule Foilsigh.WikiController do
  use Foilsigh, :controller

  alias Taifead.Repo
  alias Taifead.Wiki.Article

  def index(conn, _params) do
    articles = Repo.all(Article)
    render(conn, "index.html", articles: articles)
  end

  def recipe(conn, _params), do: render(conn, "recipe.html")
  def show(conn, _params), do: render(conn, "show.html")
end
