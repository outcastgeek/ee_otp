defmodule NewsApp.PageController do
  use NewsApp.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def gae_start(conn, _params) do
	text conn, "Application Started"
  end

  def gae_health(conn, _params) do
	text conn, "Healthy Application"
  end
end
