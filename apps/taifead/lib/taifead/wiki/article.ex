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
    |> validate_not_id(:parent_id)
    |> unique_constraint(:url_slug)
  end

  defp cast_doc(changeset, %{"doc" => doc}) when is_bitstring(doc) do
    cast(changeset, %{"doc" => Jason.decode!(doc)}, [:doc])
  end

  defp cast_doc(changeset, _) do
    changeset
  end

  defp extract_from_doc(changeset = %Ecto.Changeset{changes: %{doc: doc}}) do
    {:ok, data} = Reathai.call(Taifead.Reathai, ["wiki", [doc]])
    cast(changeset, data, [:content_html, :content_text, :title_html, :title_text])
  end

  defp extract_from_doc(changeset) do
    changeset
  end

  def validate_not_id(changeset, field) when is_atom(field) do
    validate_change(changeset, field, fn field, value ->
      case value == get_field(changeset, :id) do
        true -> [{field, "cannot be the same as :id"}]
        _ -> []
      end
    end)
  end
end
