defmodule Foilsigh.WikiView do
  use Foilsigh, :view

  import Foilsigh.Router.Helpers
  import Foilsigh.SharedComponent
  import Foilsigh.WikiComponent

  alias Foilsigh.Cldr.Number
  alias Foilsigh.Endpoint
  alias Taifead.Wiki.Article
  alias Taifead.Wiki.ArticleRevision

  def city(%ArticleRevision{mapkit_response: %{"results" => [result | _]}}) do
    case result do
      %{"countryCode" => "US"} ->
        "#{result["locality"]}, #{result["administrativeAreaCode"]}, United States"

      _ ->
        "#{result["locality"]}, #{result["country"]}"
    end
  end

  def coords(%ArticleRevision{coords: coords}), do: Foilsigh.Geo.to_decimal_string(coords)

  def created_at(%Article{revisions: [revision | _]}) do
    assigns = %{revision: revision, time_zone: time_zone(revision)}

    ~H"""
      <time datetime={datetime(@revision.updated_at, @time_zone)}><%= time_ago @revision.updated_at %></time>
    """
  end

  def created_from(%Article{revisions: [revision | _]}) do
    link(city(revision), to: map_path(Endpoint, :show, geohash(revision)))
  end

  def display_title(%Article{short_title: nil, title_text: title_text}), do: title_text
  def display_title(%Article{short_title: short_title}), do: short_title

  def dms(%ArticleRevision{coords: coords}), do: Foilsigh.Geo.to_dms_string(coords)

  def geohash(%ArticleRevision{coords: coords}), do: Foilsigh.Geo.to_geohash_string(coords, 5)

  def locations_query(%Article{revisions: revisions}) do
    [primary | secondary] = revisions |> Enum.map(&geohash/1) |> Enum.uniq()
    Plug.Conn.Query.encode(%{locations: %{primary: [primary], secondary: secondary}})
  end

  def same_city(%Article{revisions: [first | rest]}) do
    last = List.last(rest)
    city(first) == city(last)
  end

  def stylesheets("show.html", _assigns), do: ~w(/assets/templates/wiki/show.css)
  def stylesheets("index.html", _assigns), do: ~w(/assets/templates/wiki/index.css)
  def stylesheets(_action, _assigns), do: []

  def title("index.html", _assigns), do: "Wiki · Jeremy Boles"
  def title("recipe.html", _assigns), do: "Recipe · Jeremy Boles"
  def title("show.html", %{article: article}), do: "#{article.title_text} - Wiki · Jeremy Boles"

  def updated_at(%Article{revisions: revisions}) do
    revision = List.last(revisions)
    assigns = %{revision: revision, time_zone: time_zone(revision)}

    ~H"""
      <time datetime={datetime(@revision.updated_at, @time_zone)}><%= time_ago @revision.updated_at %></time>
    """
  end

  def updated_from(%Article{revisions: revisions}) do
    revision = List.last(revisions)
    link(city(revision), to: map_path(Endpoint, :show, geohash(revision)))
  end

  def updates_count(%Article{revisions: revisions}) do
    count = Enum.count(revisions)
    "#{Number.to_string!(count, format: :spellout)} #{Inflex.inflect("time", count)}"
  end

  def topic_type(%Article{} = _), do: "<b><i>seedling topic</i></b>"

  defp datetime(date), do: date |> DateTime.truncate(:second) |> DateTime.to_iso8601()
  defp datetime(date, nil), do: date |> datetime()
  defp datetime(date, tz), do: date |> DateTime.shift_zone!(tz) |> datetime()

  defp time_ago(date), do: Timex.from_now(date)

  defp time_zone(%ArticleRevision{mapkit_response: response}), do: time_zone(response)
  defp time_zone(%{"results" => [result | _]}), do: result["timezone"]
  defp time_zone(%ArticleRevision{mapkit_response: nil}), do: nil
end
