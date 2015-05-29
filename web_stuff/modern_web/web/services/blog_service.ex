
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
				 join: datum in Datum,
				 on: thing.id == datum.thing_id,
				 where: thing.name == "post",
				 select: thing,
			   preload: [data: datum])
			)
	end

	def create(blog_post) do
		Repo.transaction(
			fn ->
				thing = Repo.insert(%Thing{name: "post", version: 1})
				Repo.insert(%Datum{thing_id: thing.id, key: "title", value: blog_post.title})
				Repo.insert(%Datum{thing_id: thing.id, key: "content", value: blog_post.content})
			end	
		)
	end
end
