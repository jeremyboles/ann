defmodule Foilsigh.WikiView do
  use Foilsigh, :view

  def stylesheets("index.html", _assigns), do: ~w(/assets/wiki/index.css)
  def stylesheets(_action, _assigns), do: []

  def title("index.html", _assigns), do: "Wiki · Jeremy Boles"
end
