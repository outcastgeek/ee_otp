defmodule SessionPlug do
	import Plug.Conn

	def init(default), do: default

	def call(conn, default) do
		username = conn |> get_session(:username)
		if is_nil(username) do
			conn
			|> assign(:username, "anonymous")
		else
			conn
			|> assign(:username, username)
		end
	end
end

  
