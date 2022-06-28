defmodule Bainistigh.AppleServices do
  use Joken.Config

  @key_id "4YQKWLJNBT"
  @mapkit_url "https://snapshot.apple-mapkit.com"
  @service_id "app.boles.bainistigh"
  @team_id "6VW2HTV37Z"
  @weatherkit_url "https://weatherkit.apple.com"

  def mapkit_token, do: generate_and_sign!()

  def mapkit_snapshot_url(opts \\ %{}) do
    params = opts |> Map.merge(%{keyId: @key_id, teamId: @team_id}) |> Plug.Conn.Query.encode()
    path = "/api/v1/snapshot?#{params}"
    @mapkit_url <> path <> "&signature=" <> signature(path)
  end

  def token_config do
    default_claims(default_exp: 30 * 60, iss: @team_id, skip: [:aud])
    |> add_claim("origin", fn -> origin() end, &(&1 == origin()))
  end

  def weatherkit_request(%Geo.Point{coordinates: {lng, lat}}) do
    weatherkit_request(%{"latitude" => lat, "longitude" => lng})
  end

  def weatherkit_request(%{"latitude" => lat, "longitude" => lng}) do
    headers = %{"Authorization" => "Bearer #{weatherkit_token()}"}
    url = @weatherkit_url <> "/api/v1/weather/en/#{lat}/#{lng}?dataSets=currentWeather"
    %HTTPoison.Response{body: body, status_code: 200} = HTTPoison.get!(url, headers)
    Jason.decode!(body)
  end

  defp origin, do: Application.get_env(:bainistigh, Bainistigh.Token)[:origin]

  defp signature(path) do
    %{jwk: %{kty: {:jose_jwk_kty_ec, key}}} = __default_signer__()
    path |> JOSE.JWA.sign(:sha256, key, []) |> Base.url_encode64()
  end

  defp weatherkit_token do
    generate_and_sign!(%{id: "#{@team_id}.#{@service_id}", kid: @key_id, sub: @service_id})
  end
end
