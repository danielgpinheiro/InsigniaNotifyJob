defmodule InsigniaNotifyJob.Notifications.Update do
  alias InsigniaNotifyJob.Notifications.Notification
  alias InsigniaNotifyJob.Repo

  def call(game_notification, params) do
    game_notification
    |> Notification.changeset(params)
    |> Repo.update()
  end
end
