defmodule Foilsigh.HomeView do
  use Foilsigh, :view

  def stylesheets(_action, _assigns), do: ~w(/assets/home/index.css)

  def title(_action, _assigns), do: "Jeremy Boles"
end
