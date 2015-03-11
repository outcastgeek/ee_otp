defmodule NewsApp.SampleTopicChannel do
	use Phoenix.Channel
	require Logger

	def join("happening:all", _message, socket) do
		Logger.debug "JOIN #{socket.topic}"
		{:ok, socket}
	end

	def join("happening:" <> _priv_topic, _message, socket) do
		Logger.debug "IGNORING #{socket.topic}"
		:ignore
	end

	def handle_in("new:event", message, socket) do
		broadcast! socket, "new:event", message
		{:ok, socket}
	end

	def handle_out(event = "new:" <> _topic, message, socket) do
		reply socket, event, message
	end

	def leave(_reason, socket) do
		Logger.error inspect(_reason)
		{:ok, socket}
	end
end



