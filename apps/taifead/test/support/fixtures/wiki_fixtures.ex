defmodule Taifead.WikiFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Taifead.Wiki` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        content_html: "some content_html",
        doc: "some doc",
        title_html: "some title_html",
        url_slug: "some url_slug"
      })
      |> Taifead.Wiki.create_article()

    article
  end
end
