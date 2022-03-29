defmodule Foilsigh.WikiController do
  use Foilsigh, :controller

  def index(conn, _params), do: render(conn, "index.html")
  def recipe(conn, _params), do: render(conn, "recipe.html")
  def show(conn, _params), do: render(conn, "show.html")
end
