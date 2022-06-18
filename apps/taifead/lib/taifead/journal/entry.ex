defmodule Taifead.Journal.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "entries" do
    belongs_to(:topic, Taifead.Topics.Draft)

    field(:coords, Geo.PostGIS.Geometry)
    field(:kind, Ecto.Enum, values: [:bookmark, :checkin, :note, :photo, :quote, :video])
    field(:mapkit_response, :map)
    field(:published_at, :utc_datetime_usec)
    field(:tags, {:array, :string}, default: [])
    field(:url_slug, :string)

    timestamps()
  end

  @doc false
  def changeset(entries, attrs) do
    entries
    |> cast(attrs, [:kind, :mapkit_response, :published_at, :tags])
    |> cast_coords(attrs)
    |> generate_url_slug()
    |> unique_constraint(:url_slug)
    |> validate_required([:kind, :url_slug])
  end

  defp cast_coords(data, %{"coords" => %{"latitude" => latitude, "longitude" => longitude}}) do
    params = %{"coords" => %Geo.Point{coordinates: {latitude, longitude}, srid: 4326}}
    cast(data, params, [:coords])
  end

  defp cast_coords(data, _) do
    data
  end

  defp generate_url_slug(%Ecto.Changeset{data: %__MODULE__{url_slug: nil}} = changeset) do
    changeset |> put_change(:url_slug, Nanoid.generate(5))
  end

  defp generate_url_slug(changeset), do: changeset
end
