defmodule Foilsigh.MapView do
  use Foilsigh, :view

  import Foilsigh.GraphicsComponent
  import Foilsigh.MapComponent
  import Foilsigh.SharedComponent

  def stylesheets("index.html", _assigns), do: ~w(/assets/templates/map/index.css)
  def stylesheets(_action, _assigns), do: []

  def title(_action, _assigns), do: "Map · Jeremy Boles"
end
