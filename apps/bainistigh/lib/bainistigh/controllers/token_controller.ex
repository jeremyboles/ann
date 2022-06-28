defmodule Bainistigh.TokenController do
  use Bainistigh, :controller

  def show(conn, _params) do
    token = Bainistigh.AppleServices.mapkit_token()
    text(conn, token)
  end
end
