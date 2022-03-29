defmodule Bainistigh.TokenController do
  use Bainistigh, :controller

  def show(conn, _params) do
    # keyfile = Application.get_env(:bainistigh, __MODULE__)[:keyfile]
    origin = Application.get_env(:bainistigh, Bainistigh.Endpoint)[:url][:host]

    # signer = Joken.Signer.create("HS256", keyfile, %{"kid" => @key_id})
    # {:ok, token} = Joken.Signer.sign(%{"iss" => @team_id, "origin" => origin}, signer)
    token = Bainistigh.Token.generate_and_sign!(%{"origin" => origin})

    text(conn, token)
  end
end
