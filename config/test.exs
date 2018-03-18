use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sombrero_ui, SombreroUiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sombrero_ui, SombreroUi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "sombrero_ui_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
