defmodule BlogWeb.RSSView do
  use BlogWeb, :view
  use Timex

  def to_rfc822(date) do
    date
    |> Timezone.convert("GMT")
    |> Timex.format!("{WDshort}, {D} {Mshort} {YYYY} {h24}:{m}:{s} GMT")
  end
end
