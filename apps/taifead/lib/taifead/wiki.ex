defmodule Taifead.Wiki do
  @moduledoc """
  The Wiki context.
  """

  import Ecto.Query, warn: false

  alias Taifead.Repo
  alias Taifead.Wiki.Article
  alias Taifead.Wiki.ArticleRevision

  def article_ancestors(%Article{} = article), do: Article.ancestors(article) |> Repo.all()
  def article_ancestors(nil), do: []

  def article_by_url_slug(slug), do: Repo.get_by!(Article, url_slug: slug)
  def change_article(%Article{} = article, attrs \\ %{}), do: Article.changeset(article, attrs)
  def delete_article(%Article{} = article), do: Repo.delete(article)
  def get_article!(id), do: Repo.get!(Article, id)

  @doc """
  Fetches an article that has had its visibility set to :published.
  """
  def get_published_article!(slug) when is_bitstring(slug) do
    query =
      from(a in Article,
        where: a.url_slug == ^slug and a.visibility == :published,
        preload: [revisions: ^from(r in ArticleRevision, order_by: [asc: r.updated_at])]
      )

    Repo.one!(query)
  end

  def list_articles, do: Repo.all(Article)

  @doc """
  Lists all of the wiki articles that have had their visibility set to :published
  """
  def list_published_articles(),
    do: Repo.all(from(a in Article, where: a.visibility == :published))

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
        |> Ecto.Changeset.put_change(:content_html, article.content_html)
        |> Ecto.Changeset.put_change(:doc, article.doc)
      end)

    case Repo.transaction(result) do
      {:ok, %{article: article}} -> {:ok, article}
      error -> error
    end
  end

  def update_article(%Article{} = article, article_attrs, %{"overwrite" => _} = revision_attrs) do
    changeset = Article.changeset(article, article_attrs)

    IO.inspect(changeset)

    result =
      Ecto.Multi.new()
      |> Ecto.Multi.update(:article, changeset)
      |> Ecto.Multi.update(:revision, fn %{article: article} ->
        latest = latest_revision(article)
        changes = Map.merge(latest.changes, stringify_keys(changeset.changes))

        latest
        |> ArticleRevision.changeset(revision_attrs)
        |> Ecto.Changeset.put_change(:changes, changes)
        |> Ecto.Changeset.put_change(:content_html, article.content_html)
        |> Ecto.Changeset.put_change(:doc, article.doc)
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
        |> Ecto.Changeset.put_change(:content_html, article.content_html)
        |> Ecto.Changeset.put_change(:doc, article.doc)
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

  defp stringify_keys(data), do: data |> Jason.encode!() |> Jason.decode!()
end
