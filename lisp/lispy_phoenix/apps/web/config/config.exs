# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :web,
  namespace: Web.API

# Configures the endpoint
config :web, Web.API.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "paE7xIaG7dAAX7ehjjByi+Adk4SGjDCdFuNvgbEPgSk493v52I8yi0htUUP0WQvt",
  render_errors: [view: Web.API.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Web.API.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
