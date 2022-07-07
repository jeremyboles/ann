defmodule Foilsigh.JournalView do
  use Foilsigh, :view

  import Foilsigh.JournalComponent
  import Foilsigh.SharedComponent

  def stylesheets("show.html", _assigns), do: ~w(/assets/templates/journal/show.css)
  def stylesheets("index.html", _assigns), do: ~w(/assets/templates/journal/index.css)
  def stylesheets(_action, _assigns), do: []

  def title(_action, _assigns), do: "Journal · Jeremy Boles"

  defp day(%Date{day: day}) do
    to_string(day) <> suffix(day)
  end

  defp datetime(date), do: Date.to_iso8601(date)

  defp english(date) do
    Calendar.strftime(date, "%A, %B ") <> day(date) <> Calendar.strftime(date, ", %Y")
  end

  def suffix(num) when is_integer(num) and num > 100 do
    rem(num, 100) |> suffix()
  end

  def suffix(num) when num in 11..13, do: "th"
  def suffix(num) when num > 10, do: rem(num, 10) |> suffix()
  def suffix(1), do: "st"
  def suffix(2), do: "nd"
  def suffix(3), do: "rd"
  def suffix(_), do: "th"
end
