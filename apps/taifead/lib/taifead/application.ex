defmodule Taifead.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Taifead.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Taifead.PubSub}
      # Start a worker by calling: Taifead.Worker.start_link(arg)
      # {Taifead.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Taifead.Supervisor)
  end
end
