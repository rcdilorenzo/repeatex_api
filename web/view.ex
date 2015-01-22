defmodule RepeatexApi.View do
  use Phoenix.View, root: "web/templates"

  using do
    quote do
      import RepeatexApi.Router.Helpers
      use Phoenix.HTML
    end
  end
end
