use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :modern_web, ModernWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch"]]

# Watch static and templates for browser reloading.
config :modern_web, ModernWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Configure your database
config :modern_web, ModernWeb.Repo,
  adapter: Ecto.Adapters.Postgres,
  #username: "postgres",
  #password: "PgSQL@2015!!",
  #username: "postgres",
  #password: "postgres",
  database: "modern_web_dev",
  size: 10 # The amount of database connections in the pool

# Service Configuration
config :auth_service,
  size: 3,
  max_overflow: 9
config :blog_service,
  size: 3,
  max_overflow: 9
config :statsd_service,
  size: 3,
  max_overflow: 9
