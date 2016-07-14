defmodule InsightProj.AdHoc do
  import Ecto.Query
  alias InsightProj.Repo

  #####################
  ############ Proverbs
  #####################

  ### API

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

  #Checkout: http://stackoverflow.com/questions/4329396/mysql-select-10-random-rows-from-600k-rows-fast
  def one_random_proverb() do
    "vieupai_proverb"
    |> get_random_id
    |> random_proverb_query
    |> limit(1)
    |> Repo.one
  end

  def all_proverbs() do
    proverb_query |> Repo.all
  end

  #### Queries

  defp proverb_query, do: from p in "vieupai_proverb",
    join: pm in "vieupai_proverbmedia",
    select: %{id: p.id,
              title: p.title,
              slug: p.slug,
              body: p.body,
              image_url: pm.image_url}

  #TODO: Revisit the case for which there's no matching Record!!!
  defp random_proverb_query(rand_id), do: from pv in proverb_query, where: pv.id == ^rand_id

  #####################
  ############### Utils
  #####################

  defp get_random_id(tbl_name), do: tbl_name |> get_max_id |> possible_rand_id

  defp get_max_id(tbl) do
    max_id_query = from r in tbl, select: max(r.id)
    max_id_query |> Repo.one
  end

  defp possible_rand_id(:nil), do: 0
  #TODO: The :random module is deprecated so move to using :rand module when proper API is known!
  defp possible_rand_id(max_id) do
    :random.seed(:erlang.timestamp())
    :random.uniform(max_id)
  end
end

