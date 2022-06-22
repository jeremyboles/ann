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

  @doc """
  Generate a note.
  """
  def note_fixture(attrs \\ %{}) do
    {:ok, note} =
      attrs
      |> Enum.into(%{
        content_html: "some content_html",
        content_text: "some content_text",
        doc: %{}
      })
      |> Taifead.Journal.create_note()

    note
  end
end
