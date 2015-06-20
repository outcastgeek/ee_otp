defmodule ModernWeb.Repo do
  use Ecto.Repo, otp_app: :modern_web
	alias :exometer, as: Exometer

	def log(entry) do
    before_time = :os.timestamp
 
    result = super(entry)
 
    after_time = :os.timestamp
    diff = :timer.now_diff after_time, before_time

		unless Mix.env != :prod do
			#:ok = :exometer.update ~w(:modern_web ecto query_exec_time)a, diff / 1_000
			Exometer.update [:modern_web, :ecto, :query_exec_time], diff / 1_000

			#:ok = :exometer.update ~w(:modern_web ecto query_count)a, 1
			Exometer.update [:modern_web, :ecto, :query_count], 1
		end
 
    result
  end

  def log(entry), do: super(entry)

end
