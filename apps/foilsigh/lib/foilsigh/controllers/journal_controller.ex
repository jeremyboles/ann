defmodule Foilsigh.JournalController do
  use Foilsigh, :controller

  def index(conn, _params) do
    entries = Taifead.Journal.published_entries_by_date()
    locations = Taifead.Journal.locations()
    tags = Taifead.Journal.list_tags()

    render(conn, "index.html", entries: entries, locations: locations, tags: tags)
  end

  def show(conn, %{"slug" => slug}) do
    entry = Taifead.Journal.get_entry_by_slug!(slug)
    topic = Taifead.Topics.get_published!(entry.topic_id)

    render(conn, "show.html", entry: entry, topic: topic)
  end
end
