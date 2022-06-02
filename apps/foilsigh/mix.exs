defmodule Foilsigh.MixProject do
  use Mix.Project

  def project do
    [
      app: :foilsigh,
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
      mod: {Foilsigh.Application, []},
      extra_applications: [:logger, :runtime_tools]
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
      {:dart_sass, "~> 0.4", runtime: Mix.env() == :dev},
      {:esbuild, "~> 0.3", runtime: Mix.env() == :dev},
      {:ex_cldr_numbers, "~> 2.27.0"},
      {:ex_postcss, "~> 0.1", runtime: Mix.env() == :dev},
      {:geocalc, "~> 0.8.4"},
      {:geohash, "~> 1.2.2"},
      {:floki, ">= 0.30.0", only: :test},
      {:inflex, "~> 2.1.0"},
      {:jason, "~> 1.2"},
      {:phoenix, "~> 1.6.6"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.17.5"},
      {:plug_cowboy, "~> 2.5"},
      {:reathai, in_umbrella: true},
      {:taifead, in_umbrella: true},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:timex, "~> 3.7.8"}
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
        "cmd cd priv/js && npm ci && mv ./node_modules/ ./_node_modules/ && rsync --archive --copy-links ./_node_modules/ ./node_modules/ && rm -rf ./_node_modules",
        "sass foilsigh --no-source-map",
        "postcss foilsigh --no-map",
        "phx.digest"
      ],
      "npm.get": ["cmd cd assets && npm install", "cmd cd priv/js && npm install"]
    ]
  end
end
