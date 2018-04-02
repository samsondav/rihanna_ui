defmodule RihannaUI.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do

    config = %{}
    cleartext_options = [port: 8080, cleartext: true]
    secure_options = [port: 8443, cleartext: :false, certfile: certificate_path(), keyfile: certificate_key_path()]

    children = [
      {RihannaUI.Repo, [name: RihannaUI.Repo] ++ database_opts()},
      %{
        id: Rihanna.Job.Postgrex,
        start: {Postgrex, :start_link, [Keyword.put(database_opts(), :name, Rihanna.Job.Postgrex)]}
      },
      Supervisor.child_spec({RihannaUI.WWW, [config, cleartext_options]}, id: :www_cleartext),
      Supervisor.child_spec({RihannaUI.WWW, [config, secure_options]}, id: :www_secure),
    ]

    opts = [strategy: :one_for_one, name: RihannaUI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp certificate_path() do
    Application.app_dir(:rihanna_ui, "priv/localhost/certificate.pem")
  end

  defp certificate_key_path() do
    Application.app_dir(:rihanna_ui, "priv/localhost/certificate_key.pem")
  end

    defp database_opts() do
    [
      username: System.get_env("DB_USERNAME") || "postgres",
      password: System.get_env("DB_PASSWORD") || "postgres",
      database: System.get_env("DB_DATABASE") || "rihanna_db",
      hostname: System.get_env("DB_HOSTNAME") || "127.0.0.1",
      port: System.get_env("DB_PORT") || 54321
    ]
  end
end
