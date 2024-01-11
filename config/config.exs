# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :insignia_notify_job, :base_url, System.fetch_env("BASE_URL")
config :insignia_notify_job, :games_table_rows_selector, System.fetch_env("TABLE_ROWS_SELECTOR")
config :insignia_notify_job, :stats_selector, System.fetch_env("STATS_SELECTOR")
config :insignia_notify_job, :interval_time, System.fetch_env("INTERVAL_TIME")

config :insignia_notify_job,
  ecto_repos: [InsigniaNotifyJob.Repo]

# Configures the endpoint
config :insignia_notify_job, InsigniaNotifyJobWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: InsigniaNotifyJobWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: InsigniaNotifyJob.PubSub,
  live_view: [signing_salt: "g2+Qm7oF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
