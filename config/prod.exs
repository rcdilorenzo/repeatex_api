use Mix.Config

config :repeatex_api, RepeatexApi.Endpoint,
  http: [port: 5000],
  url: [host: "repeatex.christiandilorenzo.com", port: 80],
  cache_static_manifest: "priv/static/manifest.json"

config :logger, level: :info

config :phoenix, :serve_endpoints, true
config :repeatex_api, RepeatexApi.Endpoint, root: "."

import_config "prod.secret.exs"
