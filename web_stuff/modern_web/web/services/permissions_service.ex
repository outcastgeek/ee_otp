defmodule ModernWeb.Permissions do
	@moduledoc """
  The available User Permissions
  """
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
end

defmodule ModernWeb.PermissionService do
	@moduledoc """
  Permission Service to manage the available User Permissions
  """

	import Ecto.Query

	alias ModernWeb.Permissions
	alias ModernWeb.Role
	alias ModernWeb.Repo
	
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

