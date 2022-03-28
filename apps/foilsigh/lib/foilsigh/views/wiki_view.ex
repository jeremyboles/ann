defmodule Foilsigh.WikiView do
  use Foilsigh, :view

  def stylesheets("index.html", _assigns), do: ~w(/assets/wiki/index.css)
  def stylesheets("show.html", _assigns), do: ~w(/assets/wiki/show.css)

  def title("index.html", _assigns), do: "Wiki · Jeremy Boles"
  def title("show.html", _assigns), do: "Topic Title - Wiki · Jeremy Boles"
end
