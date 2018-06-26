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
  pubsub: [name: ElixirBackendSample.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configures Guardian
config :elixirbackendsample, ElixirBackendSample.Auth.Guardian,
  issuer: "elixirbackendsample",
  secret_key: "HNinpKh9Ne3tr8BpjCpAEh0xzCqTIG3PWsfkR2AtzvUaRIpbs6oIQ9RcmjmGPekJ"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
