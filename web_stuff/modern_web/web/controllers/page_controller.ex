defmodule ModernWeb.PageController do
  use ModernWeb.Web, :controller
	alias ModernWeb.BlogPost
	alias ModernWeb.Web.BlogService

	require Logger

	plug :scrub_params, "blog_post" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
		posts = BlogService.list_posts(3)
    #render conn, "index.html"
		render(conn, "index.html", posts: posts)
  end

"""
	alias ModernWeb.Post

  def index_post(conn, _params) do
    posts = Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end
"""


  def new(conn, _params) do
    changeset = BlogPost.changeset(%BlogPost{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"blog_post" => post_params}) do
    changeset = BlogPost.changeset(%BlogPost{}, post_params)

    if changeset.valid? do
			blog_post = changeset.changes
      BlogService.create(blog_post)

      conn
      |> put_flash(:info, "Post created successfully.")
      |> redirect(to: page_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug}) do
    post = BlogService.detail(slug)
    render(conn, "show.html", post: post)
  end

"""
  def edit(conn, %{"id" => id}) do
    post = Repo.get(Post, id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get(Post, id)
    changeset = Post.changeset(post, post_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Post updated successfully.")
      |> redirect(to: post_path(conn, :index))
    else
      render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get(Post, id)
    Repo.delete(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
"""
end
