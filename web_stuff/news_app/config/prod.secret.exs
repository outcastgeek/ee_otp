use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :news_app, NewsApp.Endpoint,
  secret_key_base: "3OTQvlqOng6E9c8LausuwSKmYPWqq+q//+AvAdfvzZ9WNkAl1ZG0bSCQXWKO/mKW"

# Configure your database
config :news_app, NewsApp.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "MySQL2014!!",
  database: "news_app_prod"
#config :news_app, NewsApp.Repo,
#  adapter: Ecto.Adapters.Postgres,
#  username: "postgres",
#  password: "postgres",
#  database: "news_app_prod"
