use Mix.Config

# General application configuration
config :rihanna_ui,
  ecto_repos: [RihannaUI.Repo]

config :rihanna_ui, RihannaUI.Repo,
  adapter: Ecto.Adapters.Postgres
