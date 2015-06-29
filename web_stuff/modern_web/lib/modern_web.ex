defmodule ModernWeb do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(ModernWeb.Endpoint, []),
      # Start the Ecto repository
      worker(ModernWeb.Repo, []),
			:poolboy.child_spec(:auth_service,
													[name: {:local, :auth_service},
													 worker_module: ModernWeb.Web.AuthService,
													 size: get_env(:auth_service, :size),
													 max_overflow: get_env(:auth_service, :max_overflow)], # Pool Options
													["The Authenticater"]),
			:poolboy.child_spec(:blog_service,
													[name: {:local, :blog_service},
													 worker_module: ModernWeb.Web.BlogService,
													 size: get_env(:blog_service, :size),
													 max_overflow: get_env(:blog_service, :max_overflow)], # Pool Options
													["Very Hard Work"]),
			:poolboy.child_spec(:statsd_service,
													[name: {:local, :statsd_service},
													 worker_module: ModernWeb.Web.StatsDService,
													 size: get_env(:statsd_service, :size),
													 max_overflow: get_env(:statsd_service, :max_overflow)], # Pool Options
													["The Stats Collector"]),
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

	defp get_env(name, key) do
		Application.get_env(name, key)
	end
end
