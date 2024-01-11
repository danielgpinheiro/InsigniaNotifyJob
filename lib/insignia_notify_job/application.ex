defmodule InsigniaNotifyJob.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    credentials =
      "GOOGLE_APPLICATION_CREDENTIALS"
      |> System.fetch_env!()
      |> Jason.decode!()

    source = {:service_account, credentials}

    children = [
      # Start the Telemetry supervisor
      InsigniaNotifyJobWeb.Telemetry,
      # Start the Ecto repository
      InsigniaNotifyJob.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: InsigniaNotifyJob.PubSub},
      # Start the Endpoint (http/https)
      InsigniaNotifyJobWeb.Endpoint,

      # Insignia HTML Crawler Interval Job
      {InsigniaNotifyJob.Interval, 0},

      # Google Auth for Firebase FCM Send
      {Goth, name: InsigniaNotifyJob.Goth, source: source}

      # Start a worker by calling: InsigniaNotifyJob.Worker.start_link(arg)
      # {InsigniaNotifyJob.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InsigniaNotifyJob.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InsigniaNotifyJobWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
