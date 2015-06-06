alias ModernWeb.Permissions
alias ModernWeb.PermissionService

import Utils.Parallel, only: [pmap: 2]

[%{:role_name => Permissions.user_role,
			:role_attr => %{:permissions => Permissions.follow + Permissions.comment + Permissions.collaborate,
											:default => true}},
 %{:role_name => Permissions.collaborator_role,
			:role_attr => %{:permissions => Permissions.follow + Permissions.comment + Permissions.collaborate + Permissions.moderate_comments,
											:default => false}},
 %{:role_name => Permissions.administrator_role,
			:role_attr => %{:permissions => 0xff,
											:default => false}}]
|> pmap(fn (role_data) -> PermissionService.insert_role(role_data) end)
