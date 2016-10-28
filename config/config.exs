# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :lrsApi,
  ecto_repos: [LrsApi.Repo]

# Configures the endpoint
config :lrsApi, LrsApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xDUj0VoIRSc2DQivbXhPLp+2heT8pZxfpPttN3zXhEMdRajc6dSeM756UB51SAUl",
  render_errors: [view: LrsApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LrsApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
