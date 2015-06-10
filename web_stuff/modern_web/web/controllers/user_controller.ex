defmodule ModernWeb.UserController do
  use ModernWeb.Web, :controller

  alias ModernWeb.User
	alias ModernWeb.Web.AuthService

  plug :scrub_params, "user" when action in [:create, :update, :process_login]
  plug :action

	def login(conn, _params) do
		changeset = User.changeset(%User{})
		render(conn, "login.html", changeset: changeset)
	end

	def process_login(conn, %{"user" => user_params}) do
		changeset = User.changeset(%User{}, user_params)
    user = unless is_nil(changeset.changes[:password_hash]), do: AuthService.authenticate(changeset.changes)
		IO.inspect user
    if is_nil(user) do
			conn
			|> put_flash(:error, "Username and/or Password was wrong")
			|> render("login.html", changeset: User.changeset(struct(User, user_params)))
			|> halt
    else
      conn
			|> put_session(:username, user_params["username"])
      |> put_flash(:info, "User successfully Logged In.")
      |> redirect(to: user_path(conn, :index))
    end
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      #Repo.insert(changeset)
			AuthService.create(changeset.changes)

      conn
      |> put_flash(:info, "User created successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "User updated successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    Repo.delete(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
