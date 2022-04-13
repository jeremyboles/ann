defmodule Foilsigh.EssaysView do
  use Foilsigh, :view

  def stylesheets("index.html", _assigns), do: ~w(/assets/essays/index.css)

  def title(_action, _assigns), do: "Essays · Jeremy Boles"
end
