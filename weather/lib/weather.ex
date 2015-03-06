defmodule Weather do
  use Supervisor

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications

  # convenience method for startup
  def start_link do
    Supervisor.start_link(__MODULE__, [], [{:name, __MODULE__}])
  end

  # supervisor callback
  def init([]) do
    child = [worker(WeatherServer, [], [])]
    supervise(child, [{:strategy, :one_for_one}, {:max_restarts, 1},
      {:max_seconds, 5}])
  end

  def start(_type, _args) do
    start_link
  end

  # Examples
  #WeatherServer.report("KGAI")
  #WeatherServer.report("KITH")

end

