use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :repeatex_api, RepeatexApi.Endpoint,
  secret_key_base: "Zk4//tXGhBqZP/erCFBr0Z6bMO2RPBKr+Qr96HqP9I2iVLJHNcCkeZgl+WPyU/pZ"

# Configure your database
config :repeatex_api, RepeatexApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "repeatex_api_prod",
  pool_size: 20
