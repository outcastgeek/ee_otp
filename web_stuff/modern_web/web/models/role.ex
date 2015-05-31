defmodule ModernWeb.Role do
  use ModernWeb.Web, :model

  schema "roles" do
    field :name, :string, index: true
    field :default, :boolean, default: false
    field :permissions, :integer
		has_many :users, User
  end

  @required_fields ~w(name default permissions)
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


