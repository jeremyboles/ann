defmodule Foilsigh.WikiView do
  use Foilsigh, :view

  import Foilsigh.Router.Helpers
  import Foilsigh.SharedComponent
  import Foilsigh.WikiComponent

  alias Foilsigh.Cldr.Number
  alias Foilsigh.Endpoint
  alias Taifead.Journal.Entry
  alias Taifead.Topics.Publication

  def city(%Publication{mapkit_response: response}) do
    "#{Taifead.Geo.city_name(response)}, #{response["country"]}"
  end

  def coords(%Publication{coords: coords}), do: Foilsigh.Geo.to_decimal_string(coords)

  def created_at(%Publication{draft: draft}) do
    [publication | _] = draft.publications |> Enum.sort_by(& &1.inserted_at)
    assigns = %{publication: publication, time_zone: time_zone(publication)}

    ~H"""
      <time datetime={datetime(@publication.inserted_at, @time_zone)}><%= time_ago @publication.inserted_at %></time>
    """
  end

  def created_from(%Publication{draft: draft}) do
    [publication | _] = draft.publications |> Enum.sort_by(& &1.inserted_at)
    link(city(publication), to: map_path(Endpoint, :show, geohash(publication)))
  end

  def display_title(%Publication{short_title: nil, title_text: title_text}), do: title_text
  def display_title(%Publication{short_title: short_title}), do: short_title

  def dms(%Publication{coords: coords}), do: Foilsigh.Geo.to_dms_string(coords)

  def geohash(%Publication{coords: coords}), do: Foilsigh.Geo.to_geohash_string(coords, 5)

  def locations_query(%Publication{draft: %{publications: publications}}) do
    [primary | secondary] = publications |> Enum.map(&geohash/1) |> Enum.uniq()
    Plug.Conn.Query.encode(%{locations: %{primary: [primary], secondary: secondary}})
  end

  defp local_time_abbr(%{entry: %Entry{mapkit_response: resp, published_at: date}} = assigns) do
    date = DateTime.shift_zone!(date, resp["timezone"])

    ~H"""
      <time timestamp={DateTime.to_iso8601(date)}><%= Calendar.strftime(date, "%b %-d") %><span class="vh">,</span><%= Calendar.strftime(date, " %Y ") %><span class="vh">@</span><%= Calendar.strftime(date, " %-I:%M %p") %></time>
    """
  end

  defp location_abbr(%{entry: %Entry{mapkit_response: resp}} = assigns) do
    case resp do
      %{"country" => "United States"} ->
        ~H"""
        <span><span><%= resp["locality"] %></span><span class="vh">,</span> <abbr title={resp["administrativeArea"]}><%= resp["administrativeAreaCode"] %></abbr><span class="vh">,</span> <abbr title="United States">US</abbr></span>
        """

      _ ->
        ~H"""
        <span><span><%= Taifead.Geo.city_name(resp) %></span><span class="vh">,</span> <abbr title={resp["country"]}><%= resp["countryCode"] %></abbr></span>
        """
    end
  end

  def same_city(%Publication{draft: %{publications: [first | rest]}}) do
    last = List.last(rest)
    city(first) == city(last)
  end

  def stylesheets("show.html", _assigns), do: ~w(/assets/templates/wiki/show.css)
  def stylesheets("index.html", _assigns), do: ~w(/assets/templates/wiki/index.css)
  def stylesheets(_action, _assigns), do: []

  def title("index.html", _assigns), do: "Wiki ?? Jeremy Boles"
  def title("recipe.html", _assigns), do: "Recipe ?? Jeremy Boles"

  def title("show.html", %{topic: %{title_text: title}}), do: "#{title} - Wiki ?? Jeremy Boles"

  def updated_at(%Publication{} = publication) do
    assigns = %{publication: publication, time_zone: time_zone(publication)}

    ~H"""
      <time datetime={datetime(@publication.updated_at, @time_zone)}><%= time_ago @publication.updated_at %></time>
    """
  end

  def updated_from(%Publication{} = publication) do
    link(city(publication), to: map_path(Endpoint, :show, geohash(publication)))
  end

  def updates_count(%Publication{} = publication) do
    count = Enum.count(publication.draft.publications)
    "#{Number.to_string!(count, format: :spellout)} #{Inflex.inflect("time", count)}"
  end

  # def topic_type(%Publication{} = _), do: "<b><i>seedling topic</i></b>"

  defp datetime(date), do: date |> DateTime.truncate(:second) |> DateTime.to_iso8601()
  defp datetime(date, nil), do: date |> datetime()
  defp datetime(date, tz), do: date |> DateTime.shift_zone!(tz) |> datetime()

  defp time_ago(date), do: Timex.from_now(date)

  defp time_zone(%Publication{mapkit_response: nil}), do: nil
  defp time_zone(%Publication{mapkit_response: response}), do: response["timezone"]
end
