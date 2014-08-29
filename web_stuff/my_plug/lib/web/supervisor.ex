
defmodule Web.Supervisor do
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @webserver_name Web.Server

  def init(:ok) do
    children = [
                 worker(Web.Server, [@webserver_name, [name: @webserver_name]])
             ]
    supervise(children, strategy: :one_for_one)
  end
end
