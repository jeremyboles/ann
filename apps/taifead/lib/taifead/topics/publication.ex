defmodule Taifead.Topics.Publication do
  use Hierarch
  use Ecto.Schema

  import Ecto.Changeset

  alias Hierarch.Ecto.UUIDLTree, as: LTree

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "topic_publications" do
    # Publication-specific fields
    belongs_to :draft, Taifead.Topics.Draft
    field :coords, Geo.PostGIS.Geometry
    field :mapkit_response, :map

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
  def changeset(publication, attrs) do
    publication
    |> cast(attrs, [:path, :short_title, :tags, :url_slug])
    |> validate_required([:doc])
  end
end
