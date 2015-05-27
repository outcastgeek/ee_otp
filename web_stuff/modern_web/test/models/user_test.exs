defmodule ModernWeb.UserTest do
  use ModernWeb.ModelCase

  alias ModernWeb.User

  @valid_attrs %{about_me: "some content", avatar_hash: "some content", confirmed: true, email: "some content", last_seen: %{day: 17, hour: 14, min: 0, month: 4, year: 2010}, location: "some content", member_since: %{day: 17, hour: 14, min: 0, month: 4, year: 2010}, name: "some content", password_hash: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
