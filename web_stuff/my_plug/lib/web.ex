
defmodule Web do
  use Application

  def start(_type, _args) do
    opts = [port: 1818, compress: true]
    if port = System.get_env("PORT") do
      IO.puts "Picked up Environment Variable: PORT=#{port}"
      opts = Keyword.put(opts, :port, String.to_integer(port))
    end
    Application.put_env(:web, :opts, opts)
    Web.Supervisor.start_link
  end
end
