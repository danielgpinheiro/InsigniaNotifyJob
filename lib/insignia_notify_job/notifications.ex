defmodule InsigniaNotifyJob.Notifications do
  alias InsigniaNotifyJob.Notifications.Create
  alias InsigniaNotifyJob.Notifications.Get
  alias InsigniaNotifyJob.Notifications.Update

  defdelegate get_by(params), to: Get, as: :get_by
  defdelegate get_all_by_user_id(user_id), to: Get, as: :get_all_by_user_id
  defdelegate create(params), to: Create, as: :call
  defdelegate update(game_notification, params), to: Update, as: :call
end
