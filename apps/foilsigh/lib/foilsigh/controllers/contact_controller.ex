defmodule Foilsigh.ContactController do
  use Foilsigh, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
