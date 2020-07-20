# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :db, DB.Repo,
  database: System.get_env("DB_NAME"),
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  hostname: System.get_env("DB_HOST")

config :db, ecto_repos: [DB.Repo]

config :ui,
  namespace: UI

# Configures the endpoint
config :ui, UIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1bR0O2vsLt13gZyx7aYLYoWh/GPGdFzCP+lbkYjjPyNBl2VZdaf/U6sXyQUyv84d",
  render_errors: [view: UIWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: UI.PubSub,
  live_view: [signing_salt: "trMB9bOM"]

# , port: 4000 Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
