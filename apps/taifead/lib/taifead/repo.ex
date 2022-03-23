defmodule Taifead.Repo do
  use Ecto.Repo,
    otp_app: :taifead,
    adapter: Ecto.Adapters.Postgres
end
