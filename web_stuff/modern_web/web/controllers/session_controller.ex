defmodule ModernWeb.SessionController do
  use ModernWeb.Web, :controller

  alias ModernWeb.User
	alias ModernWeb.Web.AuthService

  plug :scrub_params, "user" when action in [:process_login]

	def login(conn, _params) do
		changeset = User.changeset(%User{})
		render(conn, "login.html", changeset: changeset)
	end

	def process_login(conn, %{"user" => user_params}) do
		changeset = User.changeset(%User{}, user_params)
    user = unless is_nil(changeset.changes[:password_hash]), do: AuthService.authenticate(changeset.changes)
    if is_nil(user) do
			conn
			|> put_flash(:error, "Username and/or Password was wrong")
			|> render("login.html", changeset: User.changeset(struct(User, user_params)))
			|> halt
    else
      conn
			|> put_session(:username, user_params["username"])
      |> put_flash(:info, "User successfully Logged In.")
      |> redirect(to: page_path(conn, :index))
    end
  end

	def logout(conn, _) do
		conn
		|> delete_session(:username)
		|> put_flash(:info, "You have been logged out")
		|> redirect(to: page_path(conn, :index))
	end
end
