defmodule RepeatexApi.MainController do
  use RepeatexApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
