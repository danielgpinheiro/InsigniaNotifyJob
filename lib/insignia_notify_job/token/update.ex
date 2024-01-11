defmodule InsigniaNotifyJob.Token.Update do
  alias InsigniaNotifyJob.Token.Token
  alias InsigniaNotifyJob.Repo

  def call(token_users, params) do
    token_users
    |> Token.changeset(params)
    |> Repo.update()
  end
end
