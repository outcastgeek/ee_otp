alias ModernWeb.Permission

stream = Stream.each(
	[%{:role_name => "User",
			:role_attr => %{:permissions => Permission.follow + Permission.comment + Permission.collaborate,
											:default => true}},
 %{:role_name => "Collaborator",
			:role_attr => %{:permissions => Permission.follow + Permission.comment + Permission.collaborate + Permission.moderate_comments,
											:default => false}},
 %{:role_name => "Administrator",
			:role_attr => %{:permissions => 0xff,
											:default => false}}],
	fn(role_data) ->
		Permission.insert_role(role_data)
	end
)
Enum.to_list(stream)
