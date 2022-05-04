defmodule Foilsigh.EssaysView do
  use Foilsigh, :view

  import Foilsigh.EssaysComponent
  import Foilsigh.SharedComponent

  def stylesheets("index.html", _assigns), do: ~w(/assets/templates/essays/index.css)
  def stylesheets("show.html", _assigns), do: ~w(/assets/templates/essays/show.css)
  def stylesheets(_action, _assigns), do: []

  def title(_action, _assigns), do: "Essays · Jeremy Boles"
end
