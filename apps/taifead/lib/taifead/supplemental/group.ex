defmodule Taifead.Supplemental.Group do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "supplemental_groups" do
    belongs_to :article, Taifead.Wiki.Article
    has_many :links, Taifead.Supplemental.Link
    has_many :terms, Taifead.Supplemental.Term

    field(:kind, Ecto.Enum, values: [:glossary, :links])
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:kind, :title])
    |> cast_assoc(:links)
    |> cast_assoc(:terms)
    |> validate_required([:kind, :title])
  end
end
