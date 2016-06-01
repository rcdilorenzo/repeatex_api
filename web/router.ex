defmodule RepeatexApi.Router do
  use RepeatexApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RepeatexApi do
    pipe_through :browser # Use the default browser stack

    get "/", MainController, :index
  end

  scope "/api", RepeatexApi do
    pipe_through :api

    get "/", ApiController, :parse
  end
end
