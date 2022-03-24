defmodule Foilsigh.JournalView do
  use Foilsigh, :view

  def stylesheets(_action, _assigns), do: []

  def title(_action, _assigns), do: "Journal · Jeremy Boles"
end
