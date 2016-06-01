use Mix.Config

config :repeatex_api, RepeatexApi.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "pmVTEhy3bjJjesSutzIeISty61e1OVLXnJozP9yfWJOXGuxgQk4UpnJpRJROOxQe",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: RepeatexApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"

config :phoenix, :generators,
  migration: true,
  binary_id: false
