defmodule Taifead.Topics.Term do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :definition, :string
    field :title, :string
  end

  @doc false
  def changeset(appendix, attrs) do
    appendix
    |> cast(attrs, [:definition, :title])
  end
end
