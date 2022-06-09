defmodule Taifead.Topics.Appendix do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    embeds_many :links, Taifead.Topics.Link
    embeds_many :terms, Taifead.Topics.Term

    field :kind, Ecto.Enum, values: [:glossary, :links]
    field :title, :string
  end

  @doc false
  def changeset(appendix, attrs) do
    appendix
    |> cast(attrs, [:kind, :title])
  end
end
