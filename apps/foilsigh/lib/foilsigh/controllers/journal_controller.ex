defmodule Foilsigh.JournalController do
  use Foilsigh, :controller

  def index(conn, _params) do
    entries = Taifead.Journal.published_entries_by_date()
    render(conn, "index.html", entries: entries)
  end

  def show(conn, %{"slug" => slug}) do
    entry = Taifead.Journal.get_entry!(slug)
    render(conn, "show.html", entry: entry)
  end
end
