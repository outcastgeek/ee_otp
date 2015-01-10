defmodule PhxWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :phx_web

  plug Plug.Static,
    at: "/", from: :phx_web

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_phx_web_key",
    signing_salt: "S/lrlFUC",
    encryption_salt: "ez0IgS1z"

  plug :router, PhxWeb.Router
end
