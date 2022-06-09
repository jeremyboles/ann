defmodule Taifead.Topics.Link do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field :description, :string
    field :title, :string
    field :url, :string
  end

  @doc false
  def changeset(appendix, attrs) do
    appendix
    |> cast(attrs, [:description, :title, :url])
  end
end
