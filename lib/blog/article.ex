defmodule Blog.Article do
  @enforce_keys [:id, :author, :title, :body, :description, :tags, :date]
  defstruct [:id, :author, :title, :body, :description, :tags, :date]

  def build(filename, attrs, body) do
    [date, id] = filename |> Path.rootname() |> Path.split() |> Enum.take(-2)
    date = Date.from_iso8601!(date)
    struct!(__MODULE__, [id: id, date: date, body: body] ++ Map.to_list(attrs))
  end
end
