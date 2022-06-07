defmodule Taifead.Supplemental.Link do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "supplemental_links" do
    belongs_to :group, Taifead.Supplemental.Group

    field :description, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:description, :title, :url])
    |> validate_required([:title, :url])
  end
end
