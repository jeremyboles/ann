defmodule Foilsigh.EssaysController do
  use Foilsigh, :controller

  def index(conn, _params), do: render(conn, "index.html")

  def show(conn, _params), do: render(conn, "show.html")
end
