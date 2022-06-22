defmodule Taifead.Journal.Note do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "notes" do
    belongs_to :entry, Taifead.Journal.Entry

    field :content_html, :string
    field :content_text, :string
    field :doc, :map

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast_doc(attrs)
    |> extract_from_doc()
    |> validate_required([:doc])
  end

  defp cast_doc(changeset, %{"doc" => doc}) when is_map(doc) do
    cast(changeset, %{"doc" => doc}, [:doc])
  end

  defp cast_doc(changeset, %{"doc" => doc}) when is_binary(doc) do
    cast(changeset, %{"doc" => Jason.decode!(doc)}, [:doc])
  end

  defp cast_doc(changeset, attrs) do
    cast(changeset, attrs, [:doc])
  end

  defp extract_from_doc(changeset = %Ecto.Changeset{changes: %{doc: doc}}) do
    {:ok, data} = Reathai.call(Taifead.Reathai, ["journal", [doc]])
    cast(changeset, data, [:content_html, :content_text])
  end

  defp extract_from_doc(changeset), do: changeset
end
