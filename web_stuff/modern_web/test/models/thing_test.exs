defmodule ModernWeb.ThingTest do
  use ModernWeb.ModelCase

  alias ModernWeb.Thing

  @valid_attrs %{name: "some content", score: 42, version: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Thing.changeset(%Thing{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Thing.changeset(%Thing{}, @invalid_attrs)
    refute changeset.valid?
  end
end
