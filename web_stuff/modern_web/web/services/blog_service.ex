
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
			get_post_data(thing)
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
		datum_query = from datum in Datum,
		                   where: datum.key == "slug" and datum.value == ^slug,
										   select: datum
		dtm = Repo.one(datum_query)
	  thing_query = from thing in Thing,
										   join: datum in Datum,
						           on: thing.id == datum.thing_id,
						           where: thing.name == "post" and thing.id == ^dtm.thing_id,
						           preload: [data: datum],
						           select: thing
		post_data = get_post_data(Repo.one(thing_query))
		post_data									 
	end

	defp get_post_data(thing) do
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
		post = Map.merge(%{}, Agent.get(post_data, &(&1)))
		Agent.stop(post_data)
		Logger.debug post[:title]
		blog_post = %BlogPost{
			name: post[:name],
			score: post[:score],
			version: post[:version],
			title: post[:title],
			slug: post[:slug],
			content: post[:content]
		}
		blog_post
	end
end
