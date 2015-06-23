defmodule ModernWeb.LayoutView do
  use ModernWeb.Web, :view

	# Import convenience functions from controllers
  import Phoenix.Controller, only: [get_flash: 2,
																		action_name: 1,
																		controller_module: 1] # Add these as imported

	def handler_info(conn) do
    "Request Handled By: #{controller_module conn}.#{action_name conn}"
  end
end
