defmodule Foilsigh.WikiView do
  use Foilsigh, :view

  def stylesheets(_action, _assigns), do: []
  def title(_action, _assigns), do: "Wiki · Jeremy Boles"
end
