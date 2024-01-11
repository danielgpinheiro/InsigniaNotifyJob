defmodule InsigniaNotifyJob.Token.Create do
  alias InsigniaNotifyJob.Token.Token
  alias InsigniaNotifyJob.Repo

  def call(params) do
    params |> Token.changeset() |> Repo.insert()
  end
end
