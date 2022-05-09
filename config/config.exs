# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

# General application configuration
config :rihanna_ui,
  ecto_repos: [RihannaUI.Repo]

config :rihanna_ui, RihannaUI.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: 1

# Configures the endpoint
config :rihanna_ui, RihannaUIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aWZOvWfKl/FqR2bRCD7kIMQxbe8eUqpA9RjbGZE6ZuEyO2zXwWTL9PimLNVVxzeG",
  render_errors: [view: RihannaUIWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: RihannaUI.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :rihanna, jobs_table_name: (System.get_env("DB_TABLE") || "rihanna_jobs")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
