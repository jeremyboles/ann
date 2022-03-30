defmodule Bainistigh.Token do
  use Joken.Config

  def token_config do
    default_claims(default_exp: 30 * 60, iss: "6VW2HTV37Z", skip: [:aud])
    |> add_claim("origin", fn -> origin() end, &(&1 == origin()))
  end

  defp origin, do: Application.get_env(:bainistigh, Bainistigh.Token)[:origin]
end
