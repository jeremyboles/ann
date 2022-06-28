defmodule Taifead.Journal.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "entries" do
    belongs_to :topic, Taifead.Topics.Draft

    field :content_html, :string
    field :content_text, :string
    field :coords, Geo.PostGIS.Geometry
    field :doc, :map
    field :is_published, :boolean
    field :kind, Ecto.Enum, values: [:bookmark, :checkin, :note, :photo, :quote, :video]
    field :mapkit_response, :map
    field :published_at, :utc_datetime_usec
    field :tags, {:array, :string}, default: []
    field :url_slug, :string

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:is_published, :kind, :published_at, :tags, :topic_id])
    |> cast_coords(attrs)
    |> cast_doc(attrs)
    |> cast_mapkit_response(attrs)
    |> extract_from_doc()
    |> generate_url_slug()
    |> unique_constraint(:url_slug)
    |> validate_required([:kind, :url_slug])
  end

  defp cast_coords(data, %{"coords" => coords}) when is_bitstring(coords) do
    parsed = coords |> String.split() |> Enum.map(&Float.parse(&1))

    case parsed do
      [{latitude, _}, {longitude, _}] ->
        params = %{"coords" => %Geo.Point{coordinates: {longitude, latitude}, srid: 4326}}
        cast(data, params, [:coords])

      _ ->
        data
    end
  end

  defp cast_coords(data, %{"coords" => %{"latitude" => latitude, "longitude" => longitude}}) do
    params = %{"coords" => %Geo.Point{coordinates: {latitude, longitude}, srid: 4326}}
    cast(data, params, [:coords])
  end

  defp cast_coords(data, _) do
    data
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

  defp cast_mapkit_response(changeset, %{"mapkit_response" => resp}) when resp === "" do
    changeset
  end

  defp cast_mapkit_response(changeset, %{"mapkit_response" => resp}) when is_bitstring(resp) do
    cast(changeset, %{"mapkit_response" => Jason.decode!(resp)}, [:mapkit_response])
  end

  defp cast_mapkit_response(changeset, %{"mapkit_response" => resp}) do
    cast(changeset, %{"mapkit_response" => resp}, [:mapkit_response])
  end

  defp cast_mapkit_response(changeset, _) do
    changeset
  end

  defp extract_from_doc(changeset = %Ecto.Changeset{changes: %{doc: doc}}) do
    kind = Ecto.Changeset.fetch_field!(changeset, :kind)
    {:ok, data} = Reathai.call(Taifead.Reathai, ["journal", [doc, kind]])
    cast(changeset, data, [:content_html, :content_text])
  end

  defp extract_from_doc(changeset), do: changeset

  defp generate_url_slug(%Ecto.Changeset{data: %__MODULE__{url_slug: nil}} = changeset) do
    changeset |> put_change(:url_slug, Nanoid.generate(5))
  end

  defp generate_url_slug(changeset), do: changeset
end
