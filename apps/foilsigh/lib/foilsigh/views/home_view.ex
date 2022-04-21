defmodule Foilsigh.HomeView do
  use Foilsigh, :view

  def stylesheets(_action, _assigns), do: ~w(/assets/templates/home/index.css)

  def title(_action, _assigns), do: "Jeremy Boles"
end
