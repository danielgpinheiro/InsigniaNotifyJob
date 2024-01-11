defmodule InsigniaNotifyJob.Notifications.Create do
  alias InsigniaNotifyJob.Notifications.Notification
  alias InsigniaNotifyJob.Repo

  def call(params) do
    params |> Notification.changeset() |> Repo.insert()
  end
end
