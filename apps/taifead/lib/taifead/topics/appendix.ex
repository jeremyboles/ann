defmodule Taifead.Topics.Appendix do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    embeds_many :links, Taifead.Topics.Link, on_replace: :delete
    embeds_many :terms, Taifead.Topics.Term, on_replace: :delete

    field :kind, Ecto.Enum, values: [:glossary, :links]
    field :title, :string
  end

  @doc false
  def changeset(appendix, attrs) do
    appendix
    |> cast(attrs, [:kind, :title])
    |> cast_embed(:links)
    |> cast_embed(:terms)
  end
end
