defmodule AuthPlug do
	import Plug.Conn

	alias ModernWeb.User
	alias ModernWeb.Web.AuthService

	def init(options) do
		# initialize options
		options
	end

	def call(conn, _opts) do
		conn
		|> process_current_user
	end

	defp process_current_user(conn) do
	end
end
