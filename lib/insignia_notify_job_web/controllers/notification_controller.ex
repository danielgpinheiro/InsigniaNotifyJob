defmodule InsigniaNotifyJobWeb.NotificationController do
  use InsigniaNotifyJobWeb, :controller

  alias InsigniaNotifyJob.EnabledNotifications.EnabledNotification
  alias InsigniaNotifyJob.Token
  alias InsigniaNotifyJob.Notifications
  alias InsigniaNotifyJob.Settings.Setting
  alias InsigniaNotifyJobWeb.Http.Api
  alias InsigniaNotifyJobWeb.GamesController
  alias InsigniaNotifyJobWeb.SettingsController

  def notification_job do
    {_, tokens} = Token.get_all()
    games = GamesController.get_games()

    Enum.map(tokens, fn token ->
      enabled =
        case SettingsController.get_enabled_notifications_by_user_id(token.id) do
          {:ok, %EnabledNotification{enabled: enabled}} ->
            enabled

          {:error, _} ->
            true
        end

      if enabled do
        check_to_send_notification(%{
          user_id: token.id,
          firebase_user_token: token.user_token,
          games: games
        })

        {:ok}
      end

      {:ok}
    end)

    {:ok}
  end

  defp check_to_send_notification(params) do
    case Notifications.get_all_by_user_id(params.user_id) do
      {:error, _} ->
        {:ok}

      {:ok, game_notifications} ->
        notification_params = %{
          user_token: params.firebase_user_token,
          user_id: params.user_id,
          server_token: Goth.fetch!(InsigniaNotifyJob.Goth).token
        }

        Enum.map(game_notifications, fn game_notification ->
          game =
            Enum.find(params.games, fn game -> game.serial == game_notification.game_serial end)

          if game.last_active_sessions < game.active_sessions and
               game_notification.new_sessions do
            notification_params
            |> Map.put(
              :body_message,
              "\xF0\x9F\x86\x95 \xF0\x9F\x8E\xAE #{game.name} (#{game.serial}) has #{game.active_sessions} sessions now"
            )
            |> Map.put(:title_message, "New game session in Insignia")
            |> Map.put(:thumbnail, game.thumbnail)
            |> push_notification()

            {:ok}
          end

          if game.last_active_sessions > game.active_sessions and
               game_notification.end_sessions do
            notification_params
            |> Map.put(
              :body_message,
              "\xF0\x9F\x9A\xAB \xF0\x9F\x8E\xAE #{game.name} (#{game.serial}) no longer has active sessions"
            )
            |> Map.put(:title_message, "No more game session in this game")
            |> Map.put(:thumbnail, game.thumbnail)
            |> push_notification()

            {:ok}
          end

          {:ok}
        end)

        {:ok}
    end
  end

  defp push_notification(params) do
    sound =
      case SettingsController.get_settings_by_user_id(params.user_id) do
        {:ok, %Setting{notification_sound: notification_sound}} ->
          notification_sound

        {:error, _} ->
          "beep"
      end

    url = "https://fcm.googleapis.com/v1/projects/insignia-notify/messages:send"

    notification_body =
      Jason.encode!(%{
        message: %{
          token: params.user_token,
          notification: %{
            body: params.body_message,
            title: params.title_message,
            image: params.thumbnail
          },
          data: %{
            sound: sound
          }
        }
      })

    headers = [Authorization: "Bearer #{params.server_token}"]

    case Api.post(url, notification_body, headers) do
      {:ok, _} ->
        IO.inspect(notification_body, label: "OK Push Notification")
        {:ok}

      {:error, reason} ->
        IO.inspect(%{reason: reason, params: notification_body}, label: "ERROR Push Notification")
        {:ok}
    end
  end
end
