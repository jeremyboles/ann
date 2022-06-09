defmodule Taifead.TopicsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Taifead.Topics` context.
  """

  @doc """
  Generate a draft.
  """
  def draft_fixture(attrs \\ %{}) do
    {:ok, draft} =
      attrs
      |> Enum.into(%{
        doc: %{}
      })
      |> Taifead.Topics.create_draft()

    draft
  end

  @doc """
  Generate a publication.
  """
  def publication_fixture(attrs \\ %{}) do
    {:ok, publication} =
      attrs
      |> Enum.into(%{
        doc: %{}
      })
      |> Taifead.Topics.create_publication()

    publication
  end
end
