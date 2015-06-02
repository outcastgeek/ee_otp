
defmodule ModernWeb.Web.BlogService do
  @moduledoc """
  Blog Service to Provide Blogging Functionality on top of ThingDB
  """
	alias ModernWeb.Thing
	alias ModernWeb.Datum
	alias ModernWeb.BlogPost
  # Alias the data repository and import query/model functions
  alias ModernWeb.Repo
  import Ecto.Query, only: [from: 2]

	alias Slugger

	require Logger

	def list_posts(page) do
		Repo.all(
			from(thing in Thing,
				 join: datum in Datum,
				 on: thing.id == datum.thing_id,
				 where: thing.name == "post",
				 select: thing,
			   preload: [data: datum])
		)
		|> Stream.map(fn thing ->
			{:ok, post_data} = Agent.start_link(fn -> HashDict.new end)
	    Agent.update(post_data, &HashDict.put(&1, :name, thing.name))
			Agent.update(post_data, &HashDict.put(&1, :score, thing.score))
			Agent.update(post_data, &HashDict.put(&1, :version, thing.version))
			Enum.each(thing.data, fn datum ->
				cond do
					datum.key == "title" ->
						Agent.update(post_data, &HashDict.put(&1, :title, datum.value))
					datum.key == "slug" ->
						Agent.update(post_data, &HashDict.put(&1, :slug, datum.value))
					datum.key == "content" ->
						Agent.update(post_data, &HashDict.put(&1, :content, datum.value))
				end
			end)
			post = Agent.get(post_data, &(&1))
			Agent.stop(post_data)
			post
		end)
	end

	def create(blog_post) do
		Repo.transaction(
			fn ->
				thing = Repo.insert(%Thing{name: "post", version: 1})
				Repo.insert(%Datum{thing_id: thing.id, key: "title", value: blog_post.title})
				Repo.insert(%Datum{thing_id: thing.id, key: "slug", value: Slugger.slugify_downcase(blog_post.title)})
				Repo.insert(%Datum{thing_id: thing.id, key: "content", value: blog_post.content})
			end	
		)
	end

	def detail(slug) do
		# Bring up the details
	end
end
