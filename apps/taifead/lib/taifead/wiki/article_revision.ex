defmodule Taifead.Wiki.ArticleRevision do
  use Ecto.Schema

  import Ecto.Changeset

  @foreign_key_type :binary_id
  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "article_revisions" do
    belongs_to :article, Taifead.Wiki.Article

    field :changes, :map
    field(:content_html, :string)
    field :coords, Geo.PostGIS.Geometry
    field(:doc, :map)
    field :mapkit_response, :map
    field :note, :string

    timestamps()
  end

  @doc false
  def changeset(article_revision, attrs) do
    article_revision
    |> cast(attrs, [:changes, :note])
    |> cast_mapkit_response(attrs)
    |> cast_coords(attrs)
  end

  defp cast_coords(data, %{"coords" => coords}) when is_bitstring(coords) do
    parsed = coords |> String.split() |> Enum.map(&Float.parse(&1))

    case parsed do
      [{latitude, _}, {longitude, _}] ->
        params = %{"coords" => %Geo.Point{coordinates: {latitude, longitude}, srid: 4326}}
        cast(data, params, [:coords])

      _ ->
        data
    end
  end

  defp cast_coords(data, _) do
    data
  end

  defp cast_mapkit_response(changeset, %{"mapkit_response" => resp}) when resp === "" do
    changeset
  end

  defp cast_mapkit_response(changeset, %{"mapkit_response" => resp}) when is_bitstring(resp) do
    cast(changeset, %{"mapkit_response" => Jason.decode!(resp)}, [:mapkit_response])
  end

  defp cast_mapkit_response(changeset, _) do
    changeset
  end
end
