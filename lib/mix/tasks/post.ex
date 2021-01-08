defmodule Mix.Tasks.Post do
  use Mix.Task

  @shortdoc "Generate a new post"
  def run([date | [title | tags]]) do
    case Date.from_iso8601(date) do
      {:ok, _iso8601} ->
        File.mkdir(Path.join([:code.priv_dir(:blog), "articles", date]))

        Path.join([:code.priv_dir(:blog), "articles", date, title_to_filename(title)])
        |> File.write!(contents(title, tags))

      _ ->
        Mix.raise("Failed. The date should be in iso8601 format: yyyy-mm-dd")
    end

    # validate date format yyyy-mm-dd
    # File.mkdir (:ok or {:error, :eexist})
    # File.write (title in snake case with md extension)
  end

  def run(args) do
    Mix.raise("Expected arguments Date Title Tags*, got: #{args}")
  end

  defp title_to_filename(title) do
    title
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\-\s]/, "")
    |> String.replace(" ", "-")
    |> Kernel.<>(".md")
  end

  defp contents(title, tags) do
    """
    %{
      title: "#{title}",
      author: "Todd Resudek",
      tags: #{inspect(tags)},
      description: ""
    }
    ---
    """
  end
end
