defmodule ModernWeb.Web.BlogService do
  @moduledoc """
  Blog Service to Provide Blogging Functionality on top of ThingDB
  """
	alias ModernWeb.Thing
	alias ModernWeb.Datum
  # Alias the data repository and import query/model functions
  alias ModernWeb.Repo
  import Ecto.Model
  import Ecto.Query, only: [from: 2]

	def list_posts(page) do
		Repo.all(
			from(thing in Thing,
#				 join: datum in Datum,
#				 on: thing.id == datum.thing_id,
				 where: thing.name == "post",
				 select: thing)
		)
	end
end
