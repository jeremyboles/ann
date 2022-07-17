defmodule Foilsigh.CalendarController do
  use Foilsigh, :controller

  alias Taifead.Journal
  alias Taifead.Topics

  def index(conn, _params) do
    entries = Journal.list_entries() |> Enum.map(&{DateTime.to_date(&1.published_at), &1})
    publications = Topics.list_publications() |> Enum.map(&{DateTime.to_date(&1.inserted_at), &1})

    all =
      (entries ++ publications)
      |> Enum.group_by(&group_by_year/1)
      |> Enum.map(fn {year, items} ->
        months =
          items
          |> Enum.group_by(&group_by_month/1)
          |> Enum.map(fn {month, items} ->
            items =
              items
              |> Enum.sort_by(fn {date, _} -> date end, :desc)
              |> Enum.map(fn {_, item} -> item end)

            {month, items}
          end)

        {year, months}
      end)

    render(conn, "index.html", all: all)
  end

  def group_by_year({date, _}), do: date.year
  def group_by_month({data, _}), do: data.month
end
