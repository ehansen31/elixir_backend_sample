use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :elixir_backend_sample, ElixirBackendSampleWeb.Endpoint,
  secret_key_base: "U6STZZBPxHf0X4LS+xgC07Yfh3iuyrKUk/7PqCZKZdSUCqMNkSC/7rD6ks17YR+C"

# Configures Bamboo Mail Client
config :my_app, MyApp.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.domain",
  hostname: "your.domain",
  port: 1025,
  username: "your.name@your.domain", # or {:system, "SMTP_USERNAME"}
  password: "pa55word", # or {:system, "SMTP_PASSWORD"}
  tls: :if_available, # can be `:always` or `:never`
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"], # or {":system", ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  ssl: false, # can be `true`
  retries: 1,
  no_mx_lookups: false, # can be `true`
  auth: :if_available # can be `always`. If your smtp relay requires authentication set it to `always`.

# Configures Guardian
config :elixir_backend_sample, ElixirBackendSample.Auth.Guardian,
  issuer: "elixirbackendsample",
  secret_key: "secret key here"

# Configure your database
config :elixir_backend_sample, ElixirBackendSample.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "elixir_backend_sample_prod",
  pool_size: 15