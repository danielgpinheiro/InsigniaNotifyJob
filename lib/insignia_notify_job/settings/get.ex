defmodule InsigniaNotifyJob.Settings.Get do
  alias InsigniaNotifyJob.Settings.Setting
  alias InsigniaNotifyJob.Repo

  def call(user_id) do
    case Repo.get_by(Setting, user_id: user_id) do
      nil -> {:error, :not_found}
      notification_settings -> {:ok, notification_settings}
    end
  end
end
