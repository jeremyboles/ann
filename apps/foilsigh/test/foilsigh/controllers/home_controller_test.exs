defmodule Foilsigh.HomeControllerTest do
  use Foilsigh.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Home"
  end
end
