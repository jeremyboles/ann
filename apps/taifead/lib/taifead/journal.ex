defmodule Taifead.Journal do
  @moduledoc """
  The Journal context.
  """

  import Ecto.Query, warn: false
  alias Taifead.Repo

  alias Taifead.Journal.Entry

  @doc """
  Returns the list of entries.

  ## Examples

      iex> list_entries()
      [%Entry{}, ...]

  """
  def list_entries do
    Repo.all(Entry)
  end

  @doc """
  Gets a single entries.

  Raises `Ecto.NoResultsError` if the Entry does not exist.

  ## Examples

      iex> get_entry!(123)
      %Entry{}

      iex> get_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_entry!(id), do: Repo.get!(Entry, id)

  @doc """
  Creates a entries.

  ## Examples

      iex> create_entry(%{field: value})
      {:ok, %Entry{}}

      iex> create_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_entry(attrs \\ %{}) do
    %Entry{}
    |> Entry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a entries.

  ## Examples

      iex> update_entry(entries, %{field: new_value})
      {:ok, %Entry{}}

      iex> update_entry(entries, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_entry(%Entry{} = entries, attrs) do
    entries
    |> Entry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a entries.

  ## Examples

      iex> delete_entry(entries)
      {:ok, %Entry{}}

      iex> delete_entry(entries)
      {:error, %Ecto.Changeset{}}

  """
  def delete_entry(%Entry{} = entries) do
    Repo.delete(entries)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking entries changes.

  ## Examples

      iex> change_entry(entries)
      %Ecto.Changeset{data: %Entry{}}

  """
  def change_entry(%Entry{} = entries, attrs \\ %{}) do
    Entry.changeset(entries, attrs)
  end
end
