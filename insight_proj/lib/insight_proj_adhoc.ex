defmodule InsightProj.AdHoc do
  import Ecto.Query
  alias InsightProj.Repo

  def proverb_query, do: from p in "vieupai_proverb",
    join: pm in "vieupai_proverbmedia",
    select: %{title: p.title, slug: p.slug, body: p.body, image_url: pm.image_url}

  def proverb_by_slug(slug) do
    proverb_query
    |> where([pv], pv.slug == ^slug)
    |> Repo.one
  end

  def one_proverb() do
    proverb_query
    |> limit(1)
    |> Repo.one
  end

  def all_proverbs() do
    proverb_query |> Repo.all
  end
end

