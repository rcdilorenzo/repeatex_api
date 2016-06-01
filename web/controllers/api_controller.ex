defmodule RepeatexApi.ApiController do
  use RepeatexApi.Web, :controller

  def parse(conn, %{"value" => value}) when is_binary(value) do
    parsed = Repeatex.parse(value)
    formatted = case parsed do
      nil -> ""
      parsed -> Repeatex.description(parsed)
    end
    json conn, %{parsed: parsed, formatted: formatted} |> IO.inspect
  end
end
