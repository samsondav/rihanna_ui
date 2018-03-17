# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hyper_ui,
  ecto_repos: [HyperUi.Repo]

# Configures the endpoint
config :hyper_ui, HyperUiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aWZOvWfKl/FqR2bRCD7kIMQxbe8eUqpA9RjbGZE6ZuEyO2zXwWTL9PimLNVVxzeG",
  render_errors: [view: HyperUiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HyperUi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
