use Mix.Config

config :phx_web, PhxWeb.Endpoint,
  http: [port: System.get_env("PORT") || 4001]
