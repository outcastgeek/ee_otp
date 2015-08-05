defmodule ModernWeb.Repo do

  use Ecto.Repo, otp_app: :modern_web

	alias ModernWeb.Web.StatsDService

	def log(entry) do
    before_time = :os.timestamp
 
    result = super(entry)
 
    after_time = :os.timestamp
    diff = :timer.now_diff after_time, before_time

		unless Mix.env != :prod do
			StatsDService.timer diff / 1_000, "ecto.query_exec_time"
			StatsDService.increment "ecto.query_count"
		end
 
    result
  end

  #def log(entry), do: super(entry)

end
