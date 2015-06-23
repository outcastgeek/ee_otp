defmodule ModernWeb.Router do
  use ModernWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery

		plug SessionPlug
	  unless Mix.env != :prod, do: plug PlugStatsD
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ModernWeb do
    pipe_through :browser # Use the default browser stack

		resources "/roles", RoleController
		resources "/users", UserController

		get "/login", SessionController, :login
		post "/process_login", SessionController, :process_login
		delete "/logout", SessionController, :logout

    get "/", PageController, :index
		get "/new", PageController, :new
		post "/create", PageController, :create
		get "/show/:slug", PageController, :show
		get "/edit/:slug", PageController, :edit
		post "/update/:slug", PageController, :update
		delete "/delete/:slug", PageController, :delete
		#resources "/", PageController

    resources "/posts", PostController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ModernWeb do
  #   pipe_through :api
  # end
end
