defmodule Foilsigh.HomeController do
  use Foilsigh, :controller

  plug :put_layout, {Foilsigh.LayoutView, "site.html"}

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
