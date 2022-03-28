defmodule Foilsigh.GraphicsController do
  use Foilsigh, :controller

  def map(conn, params) do
    {height, _} = Integer.parse(params["height"] || "400")
    {width, _} = Integer.parse(params["width"] || "800")

    dimensions = %{"height" => height, "width" => width}

    {:ok, data} = Reathai.call(Foilsigh.Reathai, ["atlas", "map", [dimensions]])

    svg(conn, data)
  end

  def points(conn, params) do
    {height, _} = Integer.parse(params["height"] || "400")
    {width, _} = Integer.parse(params["width"] || "800")

    dimensions = %{"height" => height, "width" => width}
    options = %{"locations" => params["locations"]}

    {:ok, data} = Reathai.call(Foilsigh.Reathai, ["atlas", "points", [dimensions, options]])

    svg(conn, data)
  end

  defp svg(conn, svg) do
    {:ok, data} = Reathai.call(Foilsigh.Reathai, ["svg", "minify", [conn.request_path, svg]])

    conn
    |> put_resp_content_type("image/svg+xml")
    |> put_resp_header("cache-control", "public, max-age=31536000")
    |> send_resp(conn.status || 200, data)
  end
end
