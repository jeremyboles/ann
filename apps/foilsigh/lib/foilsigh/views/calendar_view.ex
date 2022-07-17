defmodule Foilsigh.CalendarView do
  use Foilsigh, :view

  import Foilsigh.CalendarComponent
  import Foilsigh.SharedComponent

  def display(%{item: %Taifead.Journal.Entry{}} = assigns) do
    ~H"""
      <.event item={@item} type={"#{@item.kind}"}>
        <%= raw @item.content_html %>
      </.event>
    """
  end

  def display(%{item: %Taifead.Topics.Publication{}} = assigns) do
    ~H"""
      <.event item={@item} type="wiki_update"></.event>
    """
  end

  def stylesheets("index.html", _assigns), do: ~w(/assets/templates/calendar/index.css)
  def stylesheets(_action, _assigns), do: []

  def title(_action, _assigns), do: "Calendar · Jeremy Boles"
end
