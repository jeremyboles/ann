defmodule Foilsigh.JournalController do
  use Foilsigh, :controller

  def index(conn, _params) do
    entries = Taifead.Journal.published_entries_by_date()
    tags = Taifead.Journal.list_tags() |> List.flatten() |> Enum.uniq()

    render(conn, "index.html", entries: entries, tags: tags)
  end

  def show(conn, %{"slug" => slug}) do
    entry = Taifead.Journal.get_entry_by_slug!(slug)
    topic = Taifead.Topics.get_published!(entry.topic_id)

    render(conn, "show.html", entry: entry, topic: topic)
  end
end
