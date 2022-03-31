# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Umbrella app configuration

config :bainistigh,
  ecto_repos: [Taifead.Repo],
  generators: [binary_id: true, context_app: :taifead, timestamp_type: :utc_datetime_usec]

# Configures the endpoint
config :bainistigh, Bainistigh.Endpoint,
  live_view: [signing_salt: "94Q8+jFQ"],
  pubsub_server: Taifead.PubSub,
  render_errors: [view: Bainistigh.ErrorView, accepts: ~w(html json), layout: false],
  url: [host: "localhost"]

config :foilsigh,
  generators: [binary_id: true, context_app: false],
  ecto_repos: [Taifead.Repo]

# Configures the endpoint
config :foilsigh, Foilsigh.Endpoint,
  live_view: [signing_salt: "sbYgJTIG"],
  pubsub_server: Taifead.PubSub,
  render_errors: [view: Foilsigh.ErrorView, accepts: ~w(html json), layout: false],
  url: [host: "localhost"]

config :giorraigh,
  ecto_repos: [Taifead.Repo],
  generators: [binary_id: true, context_app: false]

# Configures the endpoint
config :giorraigh, Giorraigh.Endpoint,
  live_view: [signing_salt: "mVmcADYa"],
  pubsub_server: Taifead.PubSub,
  render_errors: [view: Giorraigh.ErrorView, accepts: ~w(json), layout: false],
  url: [host: "localhost"]

# Configure Mix tasks and generators
config :taifead,
  generators: [binary_id: true, timestamp_type: :utc_datetime_usec],
  ecto_repos: [Taifead.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :taifead, Taifead.Mailer, adapter: Swoosh.Adapters.Local

# Use timestamps that support microtime, and also make sure that they
# know that they are UTC time.
config :taifead, Taifead.Repo,
  migration_foreign_key: [column: :id, type: :binary_id],
  migration_primary_key: [name: :id, type: :binary_id],
  migration_timestamps: [type: :utc_datetime_usec]

# Dependency configuration

# Configure dart-sass (the version is required)
config :dart_sass,
  version: "1.49.9",
  bainistigh: [
    args: ["--load-path=./js/node_modules/prosemirror-view/style", "css:../priv/static/assets"],
    cd: Path.expand("../apps/bainistigh/assets", __DIR__)
  ],
  foilsigh: [
    args: ["css:../priv/static/assets"],
    cd: Path.expand("../apps/foilsigh/assets", __DIR__)
  ]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.26",
  bainistigh: [
    args:
      ~w(js/app.mjs --bundle --format=esm --external:/fonts/* --external:/images/* --outdir=../priv/static/assets --target=safari15),
    cd: Path.expand("../apps/bainistigh/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# MapKit JS key
config :joken,
  default_signer: [
    jose_extra_headers: %{"kid" => "4YQKWLJNBT"},
    signer_alg: "ES256"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
