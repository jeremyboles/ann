defmodule Foilsigh.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Foilsigh.Telemetry,
      # Start the Endpoint (http/https)
      Foilsigh.Endpoint,
      # Start Reathaí for the app
      {Reathai, cd: Application.app_dir(:foilsigh, "priv/js"), name: Foilsigh.Reathai}

      # Start a worker by calling: Foilsigh.Worker.start_link(arg)
      # {Foilsigh.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Foilsigh.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Foilsigh.Endpoint.config_change(changed, removed)
    :ok
  end
end
