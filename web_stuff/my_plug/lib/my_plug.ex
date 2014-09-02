defmodule MyPlug do
  import Plug.Conn
  require Logger

  def init(options) do
    # initialize options

    options
  end

  def call(conn, _opts) do
    Logger.info "Hello world"
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello world")
  end
end

# IO.puts "Running MyPlug with Cowboy on http://localhost:4000"
# Plug.Adapters.Cowboy.http MyPlug, []

