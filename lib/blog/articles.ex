defmodule Blog.Articles do
  use NimblePublisher,
    build: Blog.Article,
    from: Path.join(:code.priv_dir(:blog), "articles/**/*.md"),
    as: :articles,
    highlighters: [:makeup_elixir, :makeup_erlang]

  def all_articles, do: @articles

  def list_articles do
    all_articles() |> Enum.sort_by(& &1.date, {:desc, Date})
  end

  def get_post_by_id(id) do
    Enum.find(all_articles(), &(&1.id == id))
  end

  def get_latest do
    List.first(list_articles())
  end
end
