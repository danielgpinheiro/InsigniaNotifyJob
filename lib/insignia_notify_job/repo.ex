defmodule InsigniaNotifyJob.Repo do
  use Ecto.Repo,
    otp_app: :insignia_notify_job,
    adapter: Ecto.Adapters.Postgres
end
