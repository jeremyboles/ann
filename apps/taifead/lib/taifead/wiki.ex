defmodule Taifead.Wiki do
  @moduledoc """
  The Wiki context.
  """

  import Ecto.Query, warn: false

  alias Taifead.Repo
  alias Taifead.Wiki.Article
  alias Taifead.Wiki.ArticleRevision

  def article_ancestors(%Article{} = article), do: Article.ancestors(article) |> Repo.all()
  def article_by_url_slug(slug), do: Repo.get_by!(Article, url_slug: slug)
  def change_article(%Article{} = article, attrs \\ %{}), do: Article.changeset(article, attrs)
  def delete_article(%Article{} = article), do: Repo.delete(article)
  def get_article!(id), do: Repo.get!(Article, id)
  def list_articles, do: Repo.all(Article)
  def ordered_articles, do: Article |> order_by([{:asc, :title_text}]) |> Repo.all()

  def create_article(article_attrs \\ %{}, revision_attrs \\ %{}) do
    changeset = Article.changeset(%Article{}, article_attrs)

    result =
      Ecto.Multi.new()
      |> Ecto.Multi.insert(:article, changeset)
      |> Ecto.Multi.insert(:revision, fn %{article: article} ->
        article
        |> Ecto.build_assoc(:revisions)
        |> ArticleRevision.changeset(revision_attrs)
        |> Ecto.Changeset.put_change(:changes, changeset.changes)
      end)

    case Repo.transaction(result) do
      {:ok, %{article: article}} -> {:ok, article}
      error -> error
    end
  end

  def update_article(%Article{} = article, article_attrs, %{"overwrite" => _} = revision_attrs) do
    changeset = Article.changeset(article, article_attrs)

    result =
      Ecto.Multi.new()
      |> Ecto.Multi.update(:article, changeset)
      |> Ecto.Multi.update(:revision, fn %{article: article} ->
        article
        |> latest_revision()
        |> ArticleRevision.changeset(revision_attrs)
        |> Ecto.Changeset.put_change(:changes, changeset.changes)
      end)

    case Repo.transaction(result) do
      {:ok, %{article: article}} -> {:ok, article}
      error -> error
    end
  end

  def update_article(%Article{} = article, article_attrs, revision_attrs) do
    changeset = Article.changeset(article, article_attrs)

    result =
      Ecto.Multi.new()
      |> Ecto.Multi.update(:article, changeset)
      |> Ecto.Multi.insert(:revision, fn %{article: article} ->
        article
        |> Ecto.build_assoc(:revisions)
        |> ArticleRevision.changeset(revision_attrs)
        |> Ecto.Changeset.put_change(:changes, changeset.changes)
      end)

    case Repo.transaction(result) do
      {:ok, %{article: article}} -> {:ok, article}
      error -> error
    end
  end

  defp latest_revision(%Article{id: article_id}) do
    query =
      ArticleRevision
      |> where([r], r.article_id == ^article_id)
      |> order_by([r], desc: r.updated_at)
      |> limit(1)

    Repo.one!(query)
  end
end
