defmodule ModernWeb.Permissions do
	@moduledoc """
  The available User Permissions
  """

	use Bitwise, only_operators: true
	
	# Rights
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

	# Roles
	@user_role "User"
	def user_role, do: @user_role

	@collaborator_role "Collaborator"
	def collaborator_role, do: @collaborator_role

	@administrator_role "Administrator"
	def administrator_role, do: @administrator_role

	# Permissions
	@user_perms @follow ||| @comment ||| @collaborate
	def user_perms, do: @user_perms

	@collaborator_perms @follow ||| @comment ||| @collaborate ||| @moderate_comments
	def collaborator_perms, do: @collaborator_perms

	@administrator_perms 0xff #@follow + @comment + @collaborate + @moderate_comments + @administer
	def administrator_perms, do: @administrator_perms
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

	@doc "Retrieves Most Basic Role Name"
	def get_most_basic_role do
		Repo.get_by!(Role, name: Permissions.user_role)
	end
end

