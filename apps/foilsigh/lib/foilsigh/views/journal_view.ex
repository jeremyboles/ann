defmodule Foilsigh.JournalView do
  use Foilsigh, :view

  def stylesheets("index.html", _assigns), do: ~w(/assets/journal/index.css)
  def stylesheets("show.html", _assigns), do: ~w(/assets/journal/show.css)

  def title(_action, _assigns), do: "Journal · Jeremy Boles"
end
