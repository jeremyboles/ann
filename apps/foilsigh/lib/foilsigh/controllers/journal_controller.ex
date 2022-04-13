defmodule Foilsigh.JournalController do
  use Foilsigh, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"slug" => slug}) do
    render(conn, "show.html", slug: slug)
  end
end
