defmodule Taifead.Supplemental.Term do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "supplemental_terms" do
    belongs_to :group, Taifead.Supplemental.Group

    field :definition, :string
    field :term, :string

    timestamps()
  end

  @doc false
  def changeset(term, attrs) do
    term
    |> cast(attrs, [:definition, :term])
    |> validate_required([:definition, :term])
  end
end
