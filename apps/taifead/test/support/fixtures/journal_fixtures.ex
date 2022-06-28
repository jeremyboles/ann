defmodule Taifead.JournalFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Taifead.Journal` context.
  """

  @doc """
  Generate a entries.
  """
  def entries_fixture(attrs \\ %{}) do
    {:ok, entries} =
      attrs
      |> Enum.into(%{
        published_at: ~N[2022-06-16 20:05:00]
      })
      |> Taifead.Journal.create_entries()

    entries
  end
end
