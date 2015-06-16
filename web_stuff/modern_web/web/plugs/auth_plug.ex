defmodule AuthPlug do
	import Plug.Conn
	import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
	# Import URL helpers from the router
  import ModernWeb.Router.Helpers


	alias ModernWeb.User
	alias ModernWeb.Web.AuthService

	def init(permissions) do
		# initialize options
		permissions
	end

	def call(conn, permissions) do
		username = conn |> get_session(:username)
		if is_nil(username) do
			cant_proceed(conn)
		else
			if AuthService.can(%{username: username}, permissions) do
				conn
			else
				cant_proceed(conn)
			end
		end
	end

	defp cant_proceed(conn) do
		conn
		|> put_flash(:error, "Not Authorized, Please Login with the Right Credentials")
		|> redirect(to: user_path(conn, :login))
	end
end
