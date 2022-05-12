defmodule Foilsigh.WikiController do
  use Foilsigh, :controller

  alias Taifead.Wiki

  def index(conn, _params) do
    articles = Wiki.list_articles()
    render(conn, "index.html", articles: articles)
  end

  def recipe(conn, _params), do: render(conn, "recipe.html")

  def show(conn, %{"slug" => slug}) do
    article = Wiki.article_by_url_slug(slug)
    ancestors = Wiki.article_ancestors(article)

    render(conn, "show.html", ancestors: ancestors, article: article)
  end
end
