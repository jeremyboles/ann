defmodule Foilsigh.JournalController do
  use Foilsigh, :controller

  def index(conn, _params) do
    entries =
      Taifead.Journal.published_entries_by_date()
      |> Map.to_list()
      |> Enum.sort_by(fn {date, _} -> date end)
      |> Enum.reverse()

    render(conn, "index.html", entries: entries)
  end

  def show(conn, %{"slug" => slug}) do
    render(conn, "show.html", slug: slug)
  end
end
