defmodule RepeatexApi.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", RepeatexApi do
    pipe_through :api

    get "/", MainController, :show
  end

end
