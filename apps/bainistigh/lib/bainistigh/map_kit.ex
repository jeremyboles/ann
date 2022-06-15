defmodule Bainistigh.MapKit do
  use Joken.Config

  @base_url "https://snapshot.apple-mapkit.com"
  @key_id "4YQKWLJNBT"
  @team_id "6VW2HTV37Z"

  def snapshot_url(opts \\ %{}) do
    params = opts |> Map.merge(%{keyId: @key_id, teamId: @team_id}) |> Plug.Conn.Query.encode()
    path = "/api/v1/snapshot?#{params}"
    @base_url <> path <> "&signature=" <> signature(path)
  end

  def token, do: generate_and_sign!()

  def token_config do
    default_claims(default_exp: 30 * 60, iss: @team_id, skip: [:aud])
    |> add_claim("origin", fn -> origin() end, &(&1 == origin()))
  end

  defp origin, do: Application.get_env(:bainistigh, Bainistigh.Token)[:origin]

  def signature(path) do
    %{jwk: %{kty: {:jose_jwk_kty_ec, key}}} = __default_signer__()
    path |> JOSE.JWA.sign(:sha256, key, []) |> Base.url_encode64()
  end
end
