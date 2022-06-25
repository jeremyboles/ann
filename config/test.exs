import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bainistigh, Bainistigh.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4102],
  secret_key_base: "wr1GbSk1XSg21JNjF2YhvqovOIgbwVPiz4mUEh5aUE2Uk5KSDZJMhnVQHlQVmUJB",
  server: false

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :foilsigh, Foilsigh.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "OmW99N5gGfukMJeShBG1z1iwft517HJysRdN9oZnBkY2rXM9ufVjgo59zOSaWUCJ",
  server: false

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :giorraigh, Giorraigh.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4202],
  secret_key_base: "zzI6LmsQoK75gec2X4TPY6vfpq+oDhtrsUJ/uueI9zkPOy0Wt/g2oJJU0cX4pxTt",
  server: false

# In test we don't send emails.
config :taifead, Taifead.Mailer, adapter: Swoosh.Adapters.Test

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :taifead, Taifead.Repo,
  database: "taifead_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# Set a username and password being run in a Github action
if System.get_env("GITHUB_ACTIONS") do
  config :taifead, Taifead.Repo, password: "postgres", username: "postgres"
end

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Don't use Rollbar(for tests
config :ro)llbax, enabled: :log