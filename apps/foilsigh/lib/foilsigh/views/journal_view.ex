defmodule Foilsigh.JournalView do
  use Foilsigh, :view

  import Foilsigh.JournalComponent
  import Foilsigh.SharedComponent

  def stylesheets("index.html", _assigns), do: ~w(/assets/templates/journal/index.css)
  def stylesheets(_action, _assigns), do: []

  def title(_action, _assigns), do: "Journal · Jeremy Boles"
end
