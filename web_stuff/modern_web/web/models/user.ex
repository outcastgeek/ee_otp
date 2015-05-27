defmodule ModernWeb.User do
  use ModernWeb.Web, :model	

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string
    field :confirmed, :boolean, default: false
    field :name, :string
    field :location, :string
    field :about_me, :string
    field :member_since, Ecto.DateTime
    field :last_seen, Ecto.DateTime
    field :avatar_hash, :string

		field :role_id, :integer

		belongs_to :roles, Role
  end

  @required_fields ~w(email username password_hash confirmed name location about_me member_since last_seen avatar_hash)
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
