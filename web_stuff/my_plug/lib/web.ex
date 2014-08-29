
defmodule Web do
  use Application

  defp current_node do
    #IO.inspect Node.self
    Node.self
  end

  def start(_type, _args) do
    opts = [port: 1818, compress: true]
    if port = System.get_env("PORT") do
      IO.puts "Picked up Environment Variable: PORT=#{port}"
      opts = Keyword.put(opts, :port, String.to_integer(port))
    end
    if node = System.get_env("NODE") do
      IO.puts "Picked up Environment Variable: NODE=#{node}"
      IO.puts "Running on Node: #{current_node()}"
    end
    if cookie = System.get_env("COOKIE") do
      IO.puts "Picked up Environment Variable: COOKIE=#{cookie}"
      IO.puts "With Cookie: #{cookie}"
    end
    Application.put_env(:web, :opts, opts)
    Web.Supervisor.start_link
  end
end
