defmodule RepeatexApi.Router do
  use Phoenix.Router

  def call(conn, opts) do
    conn = %{conn | resp_headers: CORS.headers}
    case conn.method do
      "OPTIONS" -> conn |> send_resp(204, "") |> halt
      _ -> super(conn, opts)
    end
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", RepeatexApi do
    pipe_through :api

    get "/", MainController, :show
  end
end
