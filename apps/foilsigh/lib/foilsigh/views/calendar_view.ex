defmodule Foilsigh.CalendarView do
  use Foilsigh, :view

  import Foilsigh.CalendarComponent
  import Foilsigh.SharedComponent

  def stylesheets("index.html", _assigns), do: ~w(/assets/templates/calendar/index.css)
  def stylesheets(_action, _assigns), do: []

  def title(_action, _assigns), do: "Calendar · Jeremy Boles"
end
