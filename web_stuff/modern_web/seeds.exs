alias ModernWeb.Permissions
alias ModernWeb.PermissionService

stream = Stream.each(
	[%{:role_name => "User",
			:role_attr => %{:permissions => Permissions.follow + Permissions.comment + Permissions.collaborate,
											:default => true}},
 %{:role_name => "Collaborator",
			:role_attr => %{:permissions => Permissions.follow + Permissions.comment + Permissions.collaborate + Permissions.moderate_comments,
											:default => false}},
 %{:role_name => "Administrator",
			:role_attr => %{:permissions => 0xff,
											:default => false}}],
	fn(role_data) ->
		PermissionService.insert_role(role_data)
	end
)
Enum.to_list(stream)
