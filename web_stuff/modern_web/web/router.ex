defmodule ModernWeb.Router do
  use ModernWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ModernWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
		#resources "/", PageController

    resources "/posts", PostController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ModernWeb do
  #   pipe_through :api
  # end
end
