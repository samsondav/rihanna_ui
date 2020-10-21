use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rihanna_ui, RihannaUIWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :rihanna_ui, RihannaUI.Repo,
  adapter: Ecto.Adapters.Postgres,
  show_sensitive_data_on_connection_error: true,
  url: System.get_env("DATABASE_URL", "postgres://localhost/rihanna_ui_test"),
  pool: Ecto.Adapters.SQL.Sandbox
