defmodule RepeatexApi.MainController do
  use Phoenix.Controller

  def api(conn, %{"description" => description}) do
    json conn, Repeatex.parse description
  end

  def show(conn, _) do
    render conn, "index.html"
  end
end

defimpl Poison.Encoder, for: Repeatex.Repeat do
  def encode(map, _) do
    map |> Map.from_struct |> Poison.encode!
  end
end
