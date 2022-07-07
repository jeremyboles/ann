defmodule Taifead.Journal do
  import Ecto.Query, warn: false

  alias Taifead.Journal.Entry
  alias Taifead.Repo

  def change_entry(%Entry{} = entries, attrs \\ %{}), do: Entry.changeset(entries, attrs)

  def create_entry(attrs \\ %{}) do
    %Entry{} |> Entry.changeset(attrs) |> Repo.insert() |> broadcast(:entry_created)
  end

  def delete_entry(%Entry{} = entries), do: Repo.delete(entries) |> broadcast(:entry_deleted)

  def get_entry!(id), do: Repo.get!(Entry, id)

  def list_entries do
    Repo.all(from e in Entry, order_by: [desc: e.updated_at])
  end

  def published_entries_by_date do
    query = from e in Entry, order_by: [desc: e.published_at], where: e.is_published == true
    query |> Repo.all() |> group_by_published_date()
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

  defp put_published_at(%{"published_at" => ""} = attrs), do: %{attrs | "published_at" => NaiveDateTime.utc_now()}
  defp put_published_at(%{"published_at" => nil} = attrs), do: %{attrs | "published_at" => NaiveDateTime.utc_now()}
  defp put_published_at(%{} = attrs), do: attrs

  defp published_on(%Entry{published_at: datetime}) do
    DateTime.to_date(datetime)
  end
end
