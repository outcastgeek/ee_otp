defmodule PlugStatsD do
	
  @behaviour Plug

  import Plug.Conn, only: [register_before_send: 2]

	alias ModernWeb.Web.StatsDService
 
  def init(opts), do: opts
 
  def call(conn, _config) do
    before_time = :os.timestamp
 
    register_before_send conn, fn conn ->
      after_time = :os.timestamp
      diff       = :timer.now_diff after_time, before_time
 
			StatsDService.timer diff / 1_000, "webapp.resp_time"
			StatsDService.increment "webapp.resp_count"
			StatsDService.report_health
      conn
    end
  end
end
