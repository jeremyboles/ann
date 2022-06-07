defmodule Taifead.SupplementalFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Taifead.Supplemental` context.
  """

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Taifead.Supplemental.create_group()

    group
  end

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title",
        url: "some url"
      })
      |> Taifead.Supplemental.create_link()

    link
  end

  @doc """
  Generate a term.
  """
  def term_fixture(attrs \\ %{}) do
    {:ok, term} =
      attrs
      |> Enum.into(%{
        definition: "some definition",
        term: "some term"
      })
      |> Taifead.Supplemental.create_term()

    term
  end
end
