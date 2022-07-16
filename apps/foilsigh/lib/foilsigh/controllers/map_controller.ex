defmodule Foilsigh.MapController do
  use Foilsigh, :controller

  def index(conn, _params) do
    locations = (Taifead.Journal.locations(1) ++ Taifead.Topics.locations(1)) |> Enum.uniq()
    render(conn, "index.html", locations: locations)
  end
end
