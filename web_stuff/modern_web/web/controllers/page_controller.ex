defmodule ModernWeb.PageController do
  use ModernWeb.Web, :controller

	alias ModernWeb.Permissions
	alias ModernWeb.BlogPost
	alias ModernWeb.Web.BlogService

	require Logger

	plug :scrub_params, "blog_post" when action in [:create, :update]
	plug AuthPlug, Permissions.user_perms when action in [:new, :create, :edit, :update, :delete]

	#{:ok, pool} = :poolboy.start_link([{:name, {:local, :blog_service}}, {:worker_module, ModernWeb.Web.BlogService}, {:size, 5}, {:max_overflow, 10}])

  def index(conn, _params) do
		posts = BlogService.list_posts(3)
    #render conn, "index.html"
		render(conn, "index.html", posts: posts)
  end

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

  def edit(conn, %{"slug" => slug}) do
    post = BlogService.detail(slug)
    changeset = BlogPost.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"slug" => slug, "blog_post" => post_params}) do
    post = BlogService.detail(slug)
    changeset = BlogPost.changeset(post, post_params)

    if changeset.valid? do
      BlogService.update(slug, changeset.changes)

      conn
      |> put_flash(:info, "Post updated successfully.")
      |> redirect(to: page_path(conn, :index))
    else
      render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    BlogService.delete(slug)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
