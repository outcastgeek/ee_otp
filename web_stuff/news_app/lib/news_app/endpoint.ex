defmodule NewsApp.Endpoint do
  use Phoenix.Endpoint, otp_app: :news_app

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :news_app,
    only: ~w(css images js favicon.ico robots.txt)

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_news_app_key",
    signing_salt: "Qp+viWBt",
    encryption_salt: "+LD5kQ6P"

  plug :router, NewsApp.Router
end
