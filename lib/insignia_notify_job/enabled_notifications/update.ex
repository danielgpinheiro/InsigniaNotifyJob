defmodule InsigniaNotifyJob.EnabledNotifications.Update do
  alias InsigniaNotifyJob.EnabledNotifications.EnabledNotification
  alias InsigniaNotifyJob.Repo

  def call(enabled_notifications, params) do
    enabled_notifications
    |> EnabledNotification.changeset(params)
    |> Repo.update()
  end
end
