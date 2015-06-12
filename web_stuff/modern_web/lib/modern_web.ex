defmodule ModernWeb do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

		#alias ModernWeb.Web.BlogService

    children = [
      # Start the endpoint when the application starts
      supervisor(ModernWeb.Endpoint, []),
      # Start the Ecto repository
      worker(ModernWeb.Repo, []),
			worker(ModernWeb.Web.BlogService, ["Hard Work"]),
			#:poolboy.child_spec(:blog_service,
			#										[name: {:local, :blog_service},
			#										 worker_module: ModernWeb.WebBlogService,
			#										 size: 5,
			#										 max_overflow: 10], # Pool Options
			#										["Very Hard Work"]),
			# Here you could define other workers and supervisors as children
      # worker(ModernWeb.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ModernWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ModernWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
