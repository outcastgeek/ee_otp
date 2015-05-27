defmodule ModernWeb.DatumTest do
  use ModernWeb.ModelCase

  alias ModernWeb.Datum

  @valid_attrs %{key: "some content", thing_id: 42, value: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Datum.changeset(%Datum{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Datum.changeset(%Datum{}, @invalid_attrs)
    refute changeset.valid?
  end
end
