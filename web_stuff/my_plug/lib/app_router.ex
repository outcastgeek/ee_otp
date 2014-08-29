
defmodule AppRouter do
  import Plug.Conn
  use Plug.Router

  plug :match
  plug :dispatch

  @opts MyPlug.init([])

  get "/" do
    MyPlug.call(conn, @opts)
  end

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end

# IO.puts "Running AppRouter with Cowboy on http://localhost:4000"
# Plug.Adapters.Cowboy.http AppRouter, []




