defmodule ModernWeb.Thing do
  use ModernWeb.Web, :model

  schema "things" do
    field :name, :string
    field :score, :integer
    field :version, :integer
		field :user_id, :integer
  end

  @required_fields ~w(name score version)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
