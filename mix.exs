defmodule Ann.MixProject do
  use Mix.Project

  def project do
    [
      aliases: aliases(),
      apps_path: "apps",
      deps: deps(),
      releases: releases(),
      start_permanent: Mix.env() == :prod,
      version: "0.1.0"
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  #
  # Aliases listed here are available only for this project
  # and cannot be accessed from applications inside the apps/ folder.
  defp aliases do
    [
      # run `mix setup` in all child apps
      setup: ["cmd mix setup"],

      # run `mix assets.deploy` in all Phoenix apps
      "assets.deploy": ["cmd --app bainistigh --app foilsigh mix assets.deploy"],
      "npm.deploy": ["cmd --app foilsigh mix npm.deploy"],
      "npm.get": ["cmd --app bainistigh --app foilsigh mix npm.get"]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options.
  #
  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps/ folder.
  defp deps do
    []
  end

  defp releases do
    [
      ann: [
        applications: [
          bainistigh: :permanent,
          foilsigh: :permanent,
          giorraigh: :permanent,
          reathai: :permanent,
          taifead: :permanent
        ]
      ]
    ]
  end
end
