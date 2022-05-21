defmodule Taifead.Wiki do
  @moduledoc """
  The Wiki context.
  """

  import Ecto.Query, warn: false
  alias Taifead.Repo

  alias Taifead.Wiki.Article

  def article_by_url_slug(slug) do
    Repo.get_by!(Article, url_slug: slug)
  end

  def article_ancestors(%Article{} = article) do
    Article.ancestors(article) |> Repo.all()
  end

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles do
    Repo.all(Article)
  end

  @doc """
  Returns an ordered list of articles.

  ## Examples

      iex> ordered_articles(
      [%Article{}, ...]

  """
  def ordered_articles do
    Article
    |> order_by([{:asc, :title_text}])
    |> Repo.all()
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id)

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(article_attrs \\ %{}, revision_attrs \\ %{}) do
    changeset = Article.changeset(%Article{}, article_attrs)

    result =
      Ecto.Multi.new()
      |> Ecto.Multi.insert(:article, changeset)
      |> Ecto.Multi.insert(:revision, fn %{article: article} ->
        article
        |> Ecto.build_assoc(:revisions)
        |> change_article_revision(revision_attrs)
        |> Ecto.Changeset.put_change(:changes, changeset.changes)
      end)

    case Repo.transaction(result) do
      {:ok, %{article: article}} -> {:ok, article}
      error -> error
    end
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, article_attrs, revision_attrs \\ %{}) do
    changeset = Article.changeset(article, article_attrs)

    result =
      Ecto.Multi.new()
      |> Ecto.Multi.update(:article, changeset)
      |> Ecto.Multi.insert(:revision, fn %{article: article} ->
        article
        |> Ecto.build_assoc(:revisions)
        |> change_article_revision(revision_attrs)
        |> Ecto.Changeset.put_change(:changes, changeset.changes)
      end)

    case Repo.transaction(result) do
      {:ok, %{article: article}} -> {:ok, article}
      error -> error
    end
  end

  @doc """
  Deletes a article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{data: %Article{}}

  """
  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end

  alias Taifead.Wiki.ArticleRevision

  @doc """
  Returns the list of article_revisions.

  ## Examples

      iex> list_article_revisions()
      [%ArticleRevision{}, ...]

  """
  def list_article_revisions do
    Repo.all(ArticleRevision)
  end

  @doc """
  Gets a single article_revision.

  Raises `Ecto.NoResultsError` if the Article revision does not exist.

  ## Examples

      iex> get_article_revision!(123)
      %ArticleRevision{}

      iex> get_article_revision!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article_revision!(id), do: Repo.get!(ArticleRevision, id)

  @doc """
  Creates a article_revision.

  ## Examples

      iex> create_article_revision(%{field: value})
      {:ok, %ArticleRevision{}}

      iex> create_article_revision(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article_revision(attrs \\ %{}) do
    %ArticleRevision{}
    |> ArticleRevision.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a article_revision.

  ## Examples

      iex> update_article_revision(article_revision, %{field: new_value})
      {:ok, %ArticleRevision{}}

      iex> update_article_revision(article_revision, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article_revision(%ArticleRevision{} = article_revision, attrs) do
    article_revision
    |> ArticleRevision.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article_revision.

  ## Examples

      iex> delete_article_revision(article_revision)
      {:ok, %ArticleRevision{}}

      iex> delete_article_revision(article_revision)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article_revision(%ArticleRevision{} = article_revision) do
    Repo.delete(article_revision)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article_revision changes.

  ## Examples

      iex> change_article_revision(article_revision)
      %Ecto.Changeset{data: %ArticleRevision{}}

  """
  def change_article_revision(%ArticleRevision{} = article_revision, attrs \\ %{}) do
    ArticleRevision.changeset(article_revision, attrs)
  end
end
