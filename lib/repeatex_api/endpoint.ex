defmodule RepeatexApi.Endpoint do
  use Phoenix.Endpoint, otp_app: :repeatex_api

  plug Plug.Static,
    at: "/", from: :repeatex_api

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_repeatex_api_key",
    signing_salt: "WxpqzGPC",
    encryption_salt: "WZVeOosX"

  plug :router, RepeatexApi.Router
end
