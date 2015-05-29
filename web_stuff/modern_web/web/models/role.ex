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

defmodule ModernWeb.Permission do
	@moduledoc """
  The available User Permissions
  """

	import Ecto.Query
	
	alias ModernWeb.Role
	alias ModernWeb.Repo

	@follow 0x01
	def follow, do: @follow
	
	@comment 0x02
	def comment, do: @comment
	
	@collaborate 0x04
	def collaborate, do: @collaborate
	
	@moderate_comments 0x08
	def moderate_comments, do: @moderate_comments
	
	@administer 0x80
	def administer, do: @administer

	@doc """
  Seed the Permissions and Roles
  """
	def insert_role(role_data) do
		%{:role_name => role_name,
			:role_attr => %{:permissions => permissions,
											:default => default}} = role_data
		role = Repo.one(
			from(role in Role,
					 where: role.name == ^role_name,
					 select: role)
			)
	
		if (role == nil), do: Repo.insert(%Role{name: role_name,
																						default: default,
																						permissions: permissions})
		role_name
	end
end


