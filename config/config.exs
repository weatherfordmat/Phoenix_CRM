# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cmr,
  ecto_repos: [Cmr.Repo]

# Configures the endpoint
config :cmr, CmrWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NO1fBujA7LcQj8ZjhZTgSRW8MRKx5hbu+rPU7pPE8lenGkrFB/o7CbzqtAYqwcFy",
  render_errors: [view: CmrWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cmr.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
