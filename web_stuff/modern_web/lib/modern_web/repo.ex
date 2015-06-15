defmodule ModernWeb.Repo do
  use Ecto.Repo, otp_app: :modern_web
	alias :exometer, as: Exometer

	def log({atom, cmd, params}, fun) do
    before_time = :os.timestamp
 
    result = super({atom, cmd, params}, fun)
 
    after_time = :os.timestamp
    diff = :timer.now_diff after_time, before_time
		
    #:ok = :exometer.update ~w(:modern_web ecto query_exec_time)a, diff / 1_000
		Exometer.update [:modern_web, :ecto, :query_exec_time], diff / 1_000

		#:ok = :exometer.update ~w(:modern_web ecto query_count)a, 1
		Exometer.update [:modern_web, :ecto, :query_count], 1
 
    result
  end

  def log(atom, fun), do: super(atom, fun)

end
