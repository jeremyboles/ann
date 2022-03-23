defmodule Giorraigh.PageController do
  use Giorraigh, :controller

  def index(conn, _params), do: text(conn, "OK")
end
