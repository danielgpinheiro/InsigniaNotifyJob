defmodule InsigniaNotifyJob.Settings do
  alias InsigniaNotifyJob.Settings.Create
  alias InsigniaNotifyJob.Settings.Get
  alias InsigniaNotifyJob.Settings.Update

  defdelegate get_by(user_id), to: Get, as: :call
  defdelegate create(params), to: Create, as: :call
  defdelegate update(notification_settings, params), to: Update, as: :call
end
