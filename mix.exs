defmodule RihannaUI.Mixfile do
  use Mix.Project

  def project do
    [app: :rihanna_ui,
     version: "0.1.0",
     elixir: "~> 1.6.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
      mod: {RihannaUI.Application, []}]
  end

  defp deps do
    [
      {:ace, ">= 0.0.0"},

      {:raxx_static, ">= 0.0.0"},
      {:exsync, "~> 0.2.0", only: :dev},
      {:rihanna, ">= 0.0.0"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, ">= 0.0.0"}
    ]
  end
end
