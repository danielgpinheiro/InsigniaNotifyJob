defmodule InsigniaNotifyJobWeb.SettingsController do
  use InsigniaNotifyJobWeb, :controller

  alias InsigniaNotifyJob.Settings
  alias InsigniaNotifyJob.EnabledNotifications

  def get_settings_by_user_id(user_id) do
    Settings.get_by(user_id)
  end

  def get_enabled_notifications_by_user_id(user_id) do
    EnabledNotifications.get_by(user_id)
  end
end
