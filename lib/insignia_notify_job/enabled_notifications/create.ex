defmodule InsigniaNotifyJob.EnabledNotifications.Create do
  alias InsigniaNotifyJob.EnabledNotifications.EnabledNotification
  alias InsigniaNotifyJob.Repo

  def call(params) do
    params
    |> EnabledNotification.changeset()
    |> Repo.insert()
  end
end
