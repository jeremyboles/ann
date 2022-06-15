defmodule Bainistigh.TokenController do
  use Bainistigh, :controller

  alias Bainistigh.MapKit

  def show(conn, _params) do
    text(conn, MapKit.token())
  end
end
