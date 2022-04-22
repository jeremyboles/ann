defmodule Foilsigh.WikiView do
  use Foilsigh, :view

  def stylesheets(_action, _assigns), do: []

  def title("index.html", _assigns), do: "Wiki · Jeremy Boles"
  def title("recipe.html", _assigns), do: "Recipe · Jeremy Boles"
  def title("show.html", _assigns), do: "Topic Title - Wiki · Jeremy Boles"
end
