use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_backend_sample, ElixirBackendSampleWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :elixir_backend_sample, ElixirBackendSample.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "elixir_backend_sample_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :elixir_backend_sample, ElixirBackendSample.Mailer,
  adapter: Bamboo.TestAdapter
