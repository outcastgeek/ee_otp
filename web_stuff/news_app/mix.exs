defmodule NewsApp.Mixfile do
  use Mix.Project

  def project do
    [app: :news_app,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {NewsApp, []},
     applications: [:phoenix, :cowboy, :logger]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~>0.10.0"},
		 #{:phoenix, github: "phoenixframework/phoenix", override: true},
     {:phoenix_ecto, "~> 0.1"},
		 #{:postgrex, "~> 0.8.0"},
     #{:postgrex, ">= 0.0.0"},
     {:mariaex, "~> 0.1.1"},
     {:cowboy, "~> 1.0"}]
  end
end
