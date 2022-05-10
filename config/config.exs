# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# config :dice,
#  ecto_repos: [Dice.Repo]

# Configures the endpoint
config :dice, DiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Z8YQyYMJTYjiM05cVvhynlneeI94CENhXxANsTh0trJPQlUS56gLY1isOtvIm34V",
  render_errors: [view: DiceWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Dice.PubSub,
  live_view: [signing_salt: "T8lf34gQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
