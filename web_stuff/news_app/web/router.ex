defmodule NewsApp.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NewsApp do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
		get "/_ah/start", PageController, :gae_start
		get "/_ah/health", PageController, :gae_health
  end

  # Other scopes may use custom stacks.
  # scope "/api", NewsApp do
  #   pipe_through :api
  # end
end
