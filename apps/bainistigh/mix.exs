defmodule Bainistigh.MixProject do
  use Mix.Project

  def project do
    [
      app: :bainistigh,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Bainistigh.Application, []},
      extra_applications: [:logger, :rollbax, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6.6"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:dart_sass, "~> 0.4", runtime: Mix.env() == :dev},
      {:esbuild, "~> 0.3", runtime: Mix.env() == :dev},
      {:httpoison, "~> 1.8"},
      {:rollbax, "~> 0.11.0"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:taifead, in_umbrella: true},
      {:jason, "~> 1.2"},
      {:joken, "~> 2.4"},
      {:jose, "~> 1.11.2"},
      {:plug_cowboy, "~> 2.5"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": [
        "cmd cd assets/js && npm ci && mv ./node_modules/ ./_node_modules/ && rsync --archive --copy-links ./_node_modules/ ./node_modules/ && rm -rf ./_node_modules",
        "esbuild bainistigh --minify",
        "sass bainistigh --no-source-map --style=compressed",
        "phx.digest"
      ],
      "npm.get": ["cmd cd assets/js && npm install"]
    ]
  end
end
