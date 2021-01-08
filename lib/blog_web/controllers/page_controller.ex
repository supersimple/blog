defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  def index(conn, _params) do
    articles = Blog.Articles.list_articles()
    render(conn, "index.html", articles: articles)
  end

  def show(conn, %{"id" => id}) do
    article = Blog.Articles.get_post_by_id(id)

    render(conn, "show.html",
      article: article,
      meta_description: Map.get(article, :description, "")
    )
  end
end
