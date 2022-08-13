defmodule Blog.RSS do
  use NimblePublisher,
    build: Blog.Article,
    from: Path.join(:code.priv_dir(:blog), "articles/**/*.md"),
    as: :articles,
    highlighters: []

  def articles do
    Enum.sort_by(@articles, & &1.date, {:desc, Date})
  end

  def last_build_date do
    articles()
    |> List.first()
    |> Map.get(:date)
  end
end
