defmodule ModernWeb.RoleController do
  use ModernWeb.Web, :controller

	alias ModernWeb.Permissions
  alias ModernWeb.Role

  plug :scrub_params, "role" when action in [:create, :update]
	plug AuthPlug, Permissions.administrator_perms when action in [:index, :new, :create, :show, :edit, :update, :delete]
  plug :action

  def index(conn, _params) do
    roles = Repo.all(Role)
    render(conn, "index.html", roles: roles)
  end

  def new(conn, _params) do
    changeset = Role.changeset(%Role{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"role" => role_params}) do
    changeset = Role.changeset(%Role{}, role_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Role created successfully.")
      |> redirect(to: role_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Repo.get(Role, id)
    render(conn, "show.html", role: role)
  end

  def edit(conn, %{"id" => id}) do
    role = Repo.get(Role, id)
    changeset = Role.changeset(role)
    render(conn, "edit.html", role: role, changeset: changeset)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Repo.get(Role, id)
    changeset = Role.changeset(role, role_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Role updated successfully.")
      |> redirect(to: role_path(conn, :index))
    else
      render(conn, "edit.html", role: role, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Repo.get(Role, id)
    Repo.delete(role)

    conn
    |> put_flash(:info, "Role deleted successfully.")
    |> redirect(to: role_path(conn, :index))
  end
end
