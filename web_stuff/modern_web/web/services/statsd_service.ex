defmodule ModernWeb.Web.StatsDService do
	@moduledoc """
  StatsD Service to Collect Counts and Measurements of Anything of Interest
  """

	use GenServer

	defp run(:dev, state) do
		GenServer.start_link(__MODULE__, state,
												 debug: [:trace, :statistics]
		)
	end

	defp run(:prod, state) do
		GenServer.start_link(__MODULE__, state)
	end
	
	#####
	# External API

	def start_link(state) do
		run(Mix.env, state)
	end

	def init(state) do
		{:ok, state}
	end

	def increment(count_name) do
		:poolboy.transaction(:statsd_service, fn(worker) ->
			GenServer.cast worker, {:increment, count_name}
		end)
	end

	def timer(recording, timed_entity_name) do
		:poolboy.transaction(:statsd_service, fn(worker) ->
			GenServer.cast worker, {:timer, {recording, timed_entity_name}}
		end)
	end

	def report_health do
		:poolboy.transaction(:statsd_service, fn(worker) ->
			GenServer.cast worker, {:report_health}
		end)
	end

	#####
	# GenServer Implementation

	def handle_cast({:increment, count_name}, state) do
		ExStatsD.increment count_name
		{:noreply, state}
	end

	def handle_cast({:timer, {recording, timed_entity_name}}, state) do
		ExStatsD.timer recording, timed_entity_name
		{:noreply, state}
	end

	def handle_cast({:report_health}, state) do
		ExStatsD.counter :erlang.memory(:total), "erlang.memory.total"
		ExStatsD.counter :erlang.memory(:processes), "erlang.memory.processes"
		ExStatsD.counter :erlang.memory(:processes_used), "erlang.memory.processes_used"
		ExStatsD.counter :erlang.memory(:system), "erlang.memory.system"
		ExStatsD.counter :erlang.memory(:atom), "erlang.memory.atom"
		ExStatsD.counter :erlang.memory(:atom_used), "erlang.memory.atom_used"
		ExStatsD.counter :erlang.memory(:binary), "erlang.memory.binary"
		ExStatsD.counter :erlang.memory(:code), "erlang.memory.code"
		ExStatsD.counter :erlang.memory(:ets), "erlang.memory.ets"
		{:noreply, state}
	end
end

