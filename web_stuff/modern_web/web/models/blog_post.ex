defmodule ModernWeb.BlogPost do
	@moduledoc """
  Blog Post Struct to Bind From and to the Controller
  (Client <=> Controller and Controller <=> BlogService)
  """
	use ModernWeb.Web, :model

	schema "blog_posts" do
		field :name, :string
		field :score, :integer
		field :version, :integer
    field :title, :string
		field :slug, :string
    field :content, :string

  end

  @required_fields ~w(title content)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
