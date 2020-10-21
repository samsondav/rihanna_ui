defmodule RihannaUI.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      {RihannaUI.Repo, [name: RihannaUI.Repo] ++ database_opts()},
      {Phoenix.PubSub, [name: RihannaUI.PubSub, adapter: Phoenix.PubSub.PG2]},
      %{
        id: Rihanna.Job.Postgrex,
        start: {Postgrex, :start_link, [Keyword.put(database_opts(), :name, Rihanna.Job.Postgrex)]}
      },
      supervisor(RihannaUIWeb.Endpoint, []),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RihannaUI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RihannaUIWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp database_opts() do
    []
  end
end
