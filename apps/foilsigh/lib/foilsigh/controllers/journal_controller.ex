defmodule Foilsigh.JournalController do
  use Foilsigh, :controller

  def index(conn, _params) do
    entries = Taifead.Journal.published_entries_by_date()
    kinds = Taifead.Journal.kinds()
    locations = Taifead.Journal.locations()
    tags = Taifead.Journal.list_tags()

    render(conn, "index.html",
      aggregate: aggregate(),
      entries: entries,
      kinds: kinds,
      locations: locations,
      tags: tags
    )
  end

  def show(conn, %{"slug" => slug}) do
    entry = Taifead.Journal.get_entry_by_slug!(slug)
    topic = Taifead.Topics.get_published!(entry.topic_id)

    render(conn, "show.html", entry: entry, topic: topic)
  end

  defp aggregate do
    date_range =
      Date.range(
        Taifead.Journal.first_entry().published_at,
        Taifead.Journal.last_entry().published_at
      )

    %{date_range: date_range, total: Taifead.Journal.total_entries()}
  end
end
