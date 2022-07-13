defmodule Taifead.Journal do
  import Ecto.Query, warn: false

  alias Taifead.Journal.Entry
  alias Taifead.Repo

  def change_entry(%Entry{} = entries, attrs \\ %{}), do: Entry.changeset(entries, attrs)

  def create_entry(attrs \\ %{}) do
    %Entry{} |> Entry.changeset(attrs) |> Repo.insert() |> broadcast(:entry_created)
  end

  def delete_entry(%Entry{} = entries), do: Repo.delete(entries) |> broadcast(:entry_deleted)

  def first_entry do
    Repo.one(from(e in Entry, order_by: [asc: e.published_at], limit: 1))
  end

  def get_entry!(id), do: Repo.get!(Entry, id)

  def get_entry_by_slug!(slug), do: Repo.get_by!(Entry, url_slug: slug) |> Repo.preload(:topic)

  def last_entry do
    Repo.one(from(e in Entry, order_by: [desc: e.published_at], limit: 1))
  end

  def list_entries do
    Repo.all(from(e in Entry, order_by: [desc: e.published_at]))
  end

  def list_tags do
    from(e in Entry,
      select: %{tag: fragment("unnest(?) AS tag", e.tags), count: fragment("count(*)")},
      group_by: fragment("tag"),
      order_by: [desc: fragment("count")]
    )
    |> Repo.all()
  end

  def locations(eps \\ 2) do
    %{rows: rows} =
      Repo.query!("""
        SELECT ST_Centroid(ST_Collect(coords)) AS coords, array_agg(id) AS ids, array_agg(published_at) AS dates FROM (
          SELECT id, published_at, ST_ClusterDBSCAN(coords, eps := #{eps}, minpoints := 1) OVER () AS cid, coords FROM entries WHERE is_published = TRUE
        ) AS sq GROUP BY cid;
      """)

    rows
    |> Enum.sort_by(fn [_, _, dates] -> latest(dates) end, :desc)
    |> Enum.map(fn [coords, _, _] -> coords end)
  end

  def published_entries_by_date do
    query = from(e in Entry, order_by: [desc: e.published_at], where: e.is_published == true)

    query
    |> Repo.all()
    |> group_by_published_date()
    |> Map.to_list()
    |> Enum.sort_by(fn {date, _} -> date end)
    |> Enum.reverse()
  end

  def publish_entry(attrs \\ %{}) do
    attrs
    |> Map.put("is_published", true)
    |> put_published_at()
    |> create_entry()
  end

  def update_entry(%Entry{} = entries, attrs) do
    entries |> Entry.changeset(attrs) |> Repo.update() |> broadcast(:entry_updated)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Taifead.PubSub, "entries")
  end

  def total_entries do
    Repo.aggregate(from(e in Entry, where: e.is_published == true), :count, :id)
  end

  defp broadcast({:ok, draft}, event) do
    Phoenix.PubSub.broadcast(Taifead.PubSub, "entries", {event, draft})
    {:ok, draft}
  end

  defp broadcast({:error, _reason} = error, _event) do
    IO.inspect(error, label: "error")
    error
  end

  defp group_by_published_date(entries) do
    Enum.group_by(entries, &published_on/1)
  end

  defp latest(dates) do
    dates |> Enum.sort(:desc)
  end

  defp put_published_at(%{"published_at" => ""} = attrs),
    do: %{attrs | "published_at" => NaiveDateTime.utc_now()}

  defp put_published_at(%{"published_at" => nil} = attrs),
    do: %{attrs | "published_at" => NaiveDateTime.utc_now()}

  defp put_published_at(%{} = attrs), do: attrs

  defp published_on(%Entry{published_at: datetime}) do
    DateTime.to_date(datetime)
  end
end
