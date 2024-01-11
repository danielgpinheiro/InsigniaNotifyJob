defmodule InsigniaNotifyJob.Settings.Create do
  alias InsigniaNotifyJob.Settings.Setting
  alias InsigniaNotifyJob.Repo

  def call(params) do
    params
    |> Setting.changeset()
    |> Repo.insert()
  end
end
