defmodule Bainistigh.Token do
  use Joken.Config

  def token_config do
    origin = Application.get_env(:bainistigh, Bainistigh.Endpoint)[:url][:host]

    default_claims(default_exp: 30 * 60, iss: "6VW2HTV37Z", skip: [:aud])
    |> add_claim("origin", fn -> origin end, &(&1 == origin))
  end
end
