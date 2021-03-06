defmodule ModernWeb.Mixfile do
  use Mix.Project

  def project do
    [app: :modern_web,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {ModernWeb, []},
     applications: apps(Mix.env)]
  end

	defp apps(:dev) do
		[:phoenix, :phoenix_html,
		 :cowboy, :logger,
		 :phoenix_ecto, :postgrex, #, :ex_statsd
		]
	end

	defp apps(:prod) do
		apps(:dev) ++ [:comeonin, :ex_statsd]
	end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.15.0"},
     {:phoenix_ecto, "~> 0.9.0"},
     {:postgrex, ">= 0.9.1"},
     {:phoenix_html, "~> 2.0.1"},
     {:phoenix_live_reload, "~> 0.5.2", only: :dev},
     {:cowboy, "~> 1.0"},
		 {:poolboy, "~> 1.5.1"},
		 {:exrm, "~> 0.18.6"},
		 {:slugger, "~> 0.0.1"},
		 {:earmark, "~> 0.1.17"},
		 {:comeonin, "~> 1.1.2", only: :prod},
		 #{:ex_statsd, ">= 0.5.0"}
		 {:ex_statsd, ">= 0.5.0", only: :prod}
		]
  end
end
