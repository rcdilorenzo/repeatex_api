use Mix.Config

config :repeatex_api, RepeatexApi.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn
