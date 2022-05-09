defmodule Taifead.Wiki.Article do
  use Ecto.Schema

  import Ecto.Changeset

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "articles" do
    field :content_html, :string
    field :content_text, :string
    field :doc, :map
    field :short_title, :string
    field :tags, {:array, :string}, default: []
    field :title_html, :string
    field :title_text, :string
    field :url_slug, :string
    field :visibility, Ecto.Enum, default: :private, values: [:private, :published]

    belongs_to(:parent, __MODULE__, foreign_key: :parent_id)
    has_many(:children, __MODULE__, foreign_key: :parent_id)

    has_many :revisions, Taifead.Wiki.ArticleRevision

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:parent_id, :short_title, :tags, :url_slug, :visibility])
    |> cast_doc(attrs)
    |> cast_assoc(:revisions)
    |> extract_from_doc()
    |> cast_url_slug(article)
    |> validate_not_id(:parent_id)
    |> unique_constraint(:url_slug)
  end

  defp cast_doc(changeset, %{"doc" => doc}) when is_bitstring(doc) do
    cast(changeset, %{"doc" => Jason.decode!(doc)}, [:doc])
  end

  defp cast_doc(changeset, _) do
    changeset
  end

  defp cast_url_slug(changeset = %Ecto.Changeset{changes: %{visibility: :published, url_slug: _}}, _article) do
    changeset
  end

  defp cast_url_slug(changeset = %Ecto.Changeset{changes: %{visibility: :published}}, article = %Taifead.Wiki.Article{url_slug: nil}) do
    cast(changeset, %{"url_slug" => derive_url_slug(changeset, article)}, [:url_slug])
  end

  defp cast_url_slug(changeset, _article) do
    changeset
  end

  defp derive_url_slug(%Ecto.Changeset{changes: %{short_title: short_title}}, _article), do: slug(short_title)
  defp derive_url_slug(%Ecto.Changeset{changes: %{title_text: title_text}}, _article), do: slug(title_text)
  defp derive_url_slug(_changeset, %Taifead.Wiki.Article{short_title: short_title}) when not is_nil(short_title), do: slug(short_title)
  defp derive_url_slug(_changeset, %Taifead.Wiki.Article{title_text: title_text}) when not is_nil(title_text), do: slug(title_text)
  defp derive_url_slug(_changeset, _article), do: nil

  defp extract_from_doc(changeset = %Ecto.Changeset{changes: %{doc: doc}}) do
    {:ok, data} = Reathai.call(Taifead.Reathai, ["wiki", [doc]])
    cast(changeset, data, [:content_html, :content_text, :title_html, :title_text])
  end

  defp extract_from_doc(changeset) do
    changeset
  end

  defp slug(str) when is_bitstring(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^a-zA-Z0-9 &]/, "")
    |> String.replace("&", "and")
    |> String.split()
    |> Enum.join("-")
  end

  defp slug(str) do
    str
  end

  defp validate_not_id(changeset, field) when is_atom(field) do
    validate_change(changeset, field, fn field, value ->
      case value == get_field(changeset, :id) do
        true -> [{field, "cannot be the same as :id"}]
        _ -> []
      end
    end)
  end
end
