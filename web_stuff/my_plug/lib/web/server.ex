
defmodule Web.Server do

  def start_link(webserver_name, _) do
    opts = Application.get_env(:web, :opts)
    IO.puts "Running #{webserver_name} with Cowboy on http://localhost:#{opts[:port]}"
    Plug.Adapters.Cowboy.http(AppRouter, [], opts)
  end
end
