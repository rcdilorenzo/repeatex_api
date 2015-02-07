# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :repeatex_api, RepeatexApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Xzo0DPDPJL2XoMRZVj5SD+Ad5U9cqvk9bqZ2uBBG/YPqCKJXh3X1QOPVGyI/Z7y5",
  debug_errors: false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
