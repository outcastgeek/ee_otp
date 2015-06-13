defmodule ModernWeb.Web.BlogService do
	@moduledoc """
  Blog Service to Provide Blogging Functionality on top of ThingDB
  """
	
	alias ModernWeb.Web.BlogWorker
	
	use GenServer

	######
	# External API

	def start_link(state) do
		GenServer.start_link(__MODULE__, state,
												 debug: [:trace, :statistics]
		)
	end

	def init(state) do
		{:ok, state}
	end

	def list_posts(page) do
		:poolboy.transaction(:blog_service, fn(worker) ->
			GenServer.call worker, {:list_posts, page}
		end)
	end

	def create(blog_post) do
		:poolboy.transaction(:blog_service, fn(worker) ->
			GenServer.call worker, {:create, blog_post}
		end)
	end

	def detail(slug) do
		:poolboy.transaction(:blog_service, fn(worker) ->
			GenServer.call worker, {:detail, slug}
		end)
	end

  def update(slug, updated_blog_post) do
		:poolboy.transaction(:blog_service, fn(worker) ->
			GenServer.call worker, {:update, {slug, updated_blog_post}}
		end)
	end

	def delete(slug) do
		:poolboy.transaction(:blog_service, fn(worker) ->
			GenServer.call worker, {:delete, slug}
		end)
	end
	
	#####
	# GenServer Implementation
	
	def handle_call({:list_posts, page}, _from, state) do
		{ :reply, BlogWorker.list_posts(page), state }
	end

	def handle_call({:create, blog_post}, _from, state) do
		{ :reply, BlogWorker.create(blog_post), state }
	end
	
  def handle_call({:detail, slug}, _from, state) do
		{ :reply, BlogWorker.detail(slug), state }
	end

	def handle_call({:update, {slug, updated_blog_post}}, _from, state) do
		{ :reply, BlogWorker.update(slug, updated_blog_post), state }
	end

  def handle_call({:delete, slug}, _from, state) do
		{ :reply, BlogWorker.delete(slug), state }
	end
end

defmodule ModernWeb.Web.BlogWorker do
  @moduledoc """
  Blog Service Worker
  """
	alias ModernWeb.Thing
	alias ModernWeb.Datum
	alias ModernWeb.BlogPost
  # Alias the data repository and import query/model functions
  alias ModernWeb.Repo
  import Ecto.Query, only: [from: 2]

	import Utils.Parallel, only: [pmap: 2]

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
		|> pmap(fn thing -> get_post_data(thing) end)
	end

	def create(blog_post) do
		thing = Repo.insert(%Thing{name: "post", version: 1})
		[%Datum{thing_id: thing.id, key: "title", value: blog_post.title},
		 %Datum{thing_id: thing.id, key: "slug", value: Slugger.slugify_downcase(blog_post.title)},
		 %Datum{thing_id: thing.id, key: "content", value: blog_post.content}]
		|> pmap(fn data -> Repo.insert(data) end)
	end

	def detail(slug) do
		slug
		|> get_thing_from_slug
		|> get_post_data
	end

  def update(slug, updated_blog_post) do
		slug
		|> get_thing_from_slug
		|> update_thing(updated_blog_post)
	end

	def delete(slug) do
		slug
		|> get_thing_from_slug
		|> delete_thing
	end

	defp delete_thing(thing) do
		Repo.transaction(
			fn ->
				thing.data
				|> pmap(fn datum -> Repo.delete(datum) end)
				Repo.delete(thing)
			end)
	end

	defp update_thing(thing, blog_post_update) do
		  title_update = Dict.get(blog_post_update, :title)
		  content_update = Dict.get(blog_post_update, :content)
			Repo.transaction(
				fn ->
					Repo.update(%{thing | version: thing.version + 1})
				  thing.data
					|> pmap(fn datum ->
						cond do
							datum.key == "title" ->
								unless is_nil(title_update), do:  Repo.update(%{datum | value: title_update})
					    datum.key == "slug" ->
						    unless is_nil(title_update), do: Repo.update(%{datum | value: Slugger.slugify_downcase(title_update)})
							datum.key == "content" ->
								unless is_nil(content_update), do: Repo.update(%{datum | value: content_update})
						end
					end)
				end)
	end

	defp get_thing_from_slug(slug) do
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
		Repo.one(thing_query)
	end
	
	defp get_post_data(thing) do
		{:ok, post_data} = Agent.start_link(fn -> HashDict.new end)
	  Agent.update(post_data, &HashDict.put(&1, :name, thing.name))
		Agent.update(post_data, &HashDict.put(&1, :score, thing.score))
		Agent.update(post_data, &HashDict.put(&1, :version, thing.version))
		thing.data
		|> pmap(fn datum ->
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
		blog_post = struct(BlogPost, post)
		blog_post
	end
end
