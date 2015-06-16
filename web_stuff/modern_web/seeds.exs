alias ModernWeb.Permissions
alias ModernWeb.PermissionService

import Utils.Parallel, only: [pmap: 2]

[%{:role_name => Permissions.user_role,
			:role_attr => %{:permissions => Permissions.user_perms,
											:default => true}},
 %{:role_name => Permissions.collaborator_role,
			:role_attr => %{:permissions => Permissions.collaborator_perms,
											:default => false}},
 %{:role_name => Permissions.administrator_role,
			:role_attr => %{:permissions => Permissions.administrator_perms,
											:default => false}}]
|> pmap(fn (role_data) -> PermissionService.insert_role(role_data) end)
