defmodule InsigniaNotifyJob.Settings.Update do
  alias InsigniaNotifyJob.Settings.Setting
  alias InsigniaNotifyJob.Repo

  def call(notification_settings, params) do
    notification_settings
    |> Setting.changeset(params)
    |> Repo.update()
  end
end
