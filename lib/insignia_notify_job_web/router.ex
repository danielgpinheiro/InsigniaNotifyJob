defmodule InsigniaNotifyJobWeb.Router do
  use InsigniaNotifyJobWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", InsigniaNotifyJobWeb do
    pipe_through :api

    get "/games", GamesController, :get_games_api
    get "/stats", GamesController, :get_stats_api
    get "/game_match", GamesController, :get_game_match_api
    get "/game_playlists", GamesController, :get_game_playlists_api
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:insignia_notify_job, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: InsigniaNotifyJobWeb.Telemetry
    end
  end
end
