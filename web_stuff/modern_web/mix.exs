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
     applications: get_apps()]
  end

	defp get_apps do
		apps = [:phoenix, :phoenix_html, :cowboy, :logger,
                    :phoenix_ecto, :postgrex]
		unless Mix.env != :prod, do: apps = apps ++ [:lager, :exometer]
		apps
	end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 0.13.1"},
     {:phoenix_ecto, "~> 0.4"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 1.0"},
     {:phoenix_live_reload, "~> 0.4", only: :dev},
     {:cowboy, "~> 1.0"},
		 {:poolboy, "~> 1.5.1"},
		 {:exrm, "~> 0.16.0"},
		 {:slugger, "~> 0.0.1"},
		 {:earmark, "~> 0.1.17"},
		 {:lager, github: "basho/lager", tag: "2.1.1", override: true, only: :prod},
		 {:meck, github: "eproxus/meck", tag: "0.8.3", override: true, only: :prod},
		 {:afunix, github: "tonyrog/afunix", tag: "1.0", override: true, only: :prod},
		 {:exometer_core, github: "PSPDFKit-labs/exometer_core", tag: "1.0", override: true, only: :prod},
     {:exometer, github: "PSPDFKit-labs/exometer", tag: "1.1", override: true, only: :prod},
     {:edown, github: "uwiger/edown", tag: "0.6", override: true, only: :prod}]
  end
end
