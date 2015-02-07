defmodule RepeatexApi.MainController do
  use Phoenix.Controller

  plug :action

  def api(conn, %{"description" => description}) do
    json conn, Repeatex.Parser.parse description
  end

  def show(conn, _) do
    render conn, "index.html"
  end
end

defimpl Poison.Encoder, for: Repeatex.Repeat do
  def encode(%Repeatex.Repeat{days: days} = map, _) do
    days = days |> Enum.map fn
      ({int, atom}) -> Map.put(%{}, atom, int)
      (any) -> any
    end
    map |> Map.from_struct |> Map.put(:days, days) |> Poison.encode!
  end
end
