defmodule Bainistigh.TokenController do
  use Bainistigh, :controller

  def show(conn, _params) do
    token = Bainistigh.Token.generate_and_sign!()
    text(conn, token)
  end
end
