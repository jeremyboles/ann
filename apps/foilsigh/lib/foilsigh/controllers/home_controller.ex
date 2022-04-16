defmodule Foilsigh.HomeController do
  use Foilsigh, :controller

  plug :put_layout, {Foilsigh.LayoutView, "app_new.html"}
  plug :put_root_layout, {Foilsigh.LayoutView, "root_new.html"}

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
