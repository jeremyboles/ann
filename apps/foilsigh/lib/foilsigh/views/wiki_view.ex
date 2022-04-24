defmodule Foilsigh.WikiView do
  use Foilsigh, :view

  import Foilsigh.SharedComponent
  import Foilsigh.WikiComponent

  def stylesheets("index.html", _assigns), do: ~w(/assets/templates/wiki/index.css)
  def stylesheets(_action, _assigns), do: []

  def title("index.html", _assigns), do: "Wiki · Jeremy Boles"
  def title("recipe.html", _assigns), do: "Recipe · Jeremy Boles"
  def title("show.html", _assigns), do: "Topic Title - Wiki · Jeremy Boles"
end
