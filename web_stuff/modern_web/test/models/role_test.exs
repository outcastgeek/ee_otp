defmodule ModernWeb.RoleTest do
  use ModernWeb.ModelCase

  alias ModernWeb.Role

  @valid_attrs %{default: true, name: "some content", permissions: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Role.changeset(%Role{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Role.changeset(%Role{}, @invalid_attrs)
    refute changeset.valid?
  end
end
