# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixir_backend_sample,
  ecto_repos: [ElixirBackendSample.Repo]

# Configures the endpoint
config :elixir_backend_sample, ElixirBackendSampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XajLnAZL5zZ1gLGsl3LhaA0P6CnFQeVwSd0hUSUWqzGpYtQXCy5iErHy4PQaKx6g",
  render_errors: [view: ElixirBackendSampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirBackendSample.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configures Guardian
config :elixirbackendsample, ElixirBackendSample.Auth.Guardian,
  issuer: "elixirbackendsample",
  secret_key: "HNinpKh9Ne3tr8BpjCpAEh0xzCqTIG3PWsfkR2AtzvUaRIpbs6oIQ9RcmjmGPekJ"

# Configures Bamboo Mail Client
config :elixirbackendsample, ElixirBackendSample.Mailer,
  adapter: Bamboo.LocalAdapter

# config :my_app, MyApp.Mailer,
#   adapter: Bamboo.SMTPAdapter,
#   server: "smtp.domain",
#   hostname: "your.domain",
#   port: 1025,
#   username: "your.name@your.domain", # or {:system, "SMTP_USERNAME"}
#   password: "pa55word", # or {:system, "SMTP_PASSWORD"}
#   tls: :if_available, # can be `:always` or `:never`
#   allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"], # or {":system", ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
#   ssl: false, # can be `true`
#   retries: 1,
#   no_mx_lookups: false, # can be `true`
#   auth: :if_available # can be `always`. If your smtp relay requires authentication set it to `always`.



# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
