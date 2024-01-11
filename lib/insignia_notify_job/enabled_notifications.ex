defmodule InsigniaNotifyJob.EnabledNotifications do
  alias InsigniaNotifyJob.EnabledNotifications.Create
  alias InsigniaNotifyJob.EnabledNotifications.Get
  alias InsigniaNotifyJob.EnabledNotifications.Update

  defdelegate get_by(user_id), to: Get, as: :call
  defdelegate create(params), to: Create, as: :call
  defdelegate update(enabled_notifications, params), to: Update, as: :call
end
