defmodule RepeatexApi.ErrorView do
  use RepeatexApi.View

  def render("404.html", _assigns) do
    "Page not found - 404"
  end

  def render("500.html", _assigns) do
    "Server internal error - 500"
  end

  def render(_, assigns) do
    render "500.html", assigns
  end
end
