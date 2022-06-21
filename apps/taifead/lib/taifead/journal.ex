defmodule Taifead.Journal do
  import Ecto.Query, warn: false

  alias Taifead.Journal.Entry
  alias Taifead.Repo

  def change_entry(%Entry{} = entries, attrs \\ %{}), do: Entry.changeset(entries, attrs)

  def create_entry(attrs \\ %{}) do
    %Entry{} |> Entry.changeset(attrs) |> Repo.insert() |> broadcast(:entry_created)
  end

  def delete_entry(%Entry{} = entries), do: Repo.delete(entries)

  def get_entry!(id), do: Repo.get!(Entry, id)
  def list_entries, do: Repo.all(Entry)

  def publish_entry(attrs \\ %{}) do
    attrs
    |> Map.put("is_published", true)
    |> Map.put("published_at", NaiveDateTime.utc_now())
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
end
