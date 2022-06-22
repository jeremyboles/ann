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
    |> Map.put_new("published_at", NaiveDateTime.utc_now())
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

  alias Taifead.Journal.Note

  @doc """
  Returns the list of notes.

  ## Examples

      iex> list_notes()
      [%Note{}, ...]

  """
  def list_notes do
    Repo.all(Note)
  end

  @doc """
  Gets a single note.

  Raises `Ecto.NoResultsError` if the Note does not exist.

  ## Examples

      iex> get_note!(123)
      %Note{}

      iex> get_note!(456)
      ** (Ecto.NoResultsError)

  """
  def get_note!(id), do: Repo.get!(Note, id)

  @doc """
  Creates a note.

  ## Examples

      iex> create_note(%{field: value})
      {:ok, %Note{}}

      iex> create_note(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a note.

  ## Examples

      iex> update_note(note, %{field: new_value})
      {:ok, %Note{}}

      iex> update_note(note, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a note.

  ## Examples

      iex> delete_note(note)
      {:ok, %Note{}}

      iex> delete_note(note)
      {:error, %Ecto.Changeset{}}

  """
  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking note changes.

  ## Examples

      iex> change_note(note)
      %Ecto.Changeset{data: %Note{}}

  """
  def change_note(%Note{} = note, attrs \\ %{}) do
    Note.changeset(note, attrs)
  end
end
