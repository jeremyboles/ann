defmodule Taifead.Topics.Draft do
  use Hierarch
  use Ecto.Schema

  import Ecto.Changeset

  alias Hierarch.Ecto.UUIDLTree, as: LTree

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "topic_drafts" do
    # Draft-specific fields
    has_many :publications, Taifead.Topics.Publication
    field :status, Ecto.Enum, default: :changed, values: [:changed, :bulk]

    # Common fields shared with Taifead.Topics.Publication from the `topics` table
    embeds_many :appendices, Taifead.Topics.Appendix
    field :content_html, :string
    field :content_text, :string
    field :doc, :map
    field :path, LTree, default: ""
    field :short_title, :string
    field :tags, {:array, :string}, default: []
    field :title_html, :string
    field :title_text, :string
    field :url_slug, :string

    timestamps()
  end

  @doc false
  def changeset(draft, attrs) do
    draft
    |> cast(attrs, [:doc, :path, :short_title, :tags, :url_slug])
    |> extract_from_doc()
  end

  defp extract_from_doc(changeset = %Ecto.Changeset{changes: %{doc: doc}}) do
    {:ok, data} = Reathai.call(Taifead.Reathai, ["wiki", [doc]])
    cast(changeset, data, [:content_html, :content_text, :title_html, :title_text])
  end

  defp extract_from_doc(changeset), do: changeset
end
