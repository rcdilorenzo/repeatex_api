use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :repeatex_api, RepeatexApi.Endpoint,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT") || 4000],
  server: true,
  secret_key_base: "Xzo0DPDPJL2XoMRZVj5SD+Ad5U9cqvk9bqZ2uBBG/YPqCKJXh3X1QOPVGyI/Z7y5"

config :logger,
  level: :info

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :repeatex_api, RepeatexApi.Endpoint, server: true
#
