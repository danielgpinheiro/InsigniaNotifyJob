defmodule InsigniaNotifyJob.Token do
  alias InsigniaNotifyJob.Token.Create
  alias InsigniaNotifyJob.Token.Get
  alias InsigniaNotifyJob.Token.Update

  defdelegate get_by(token), to: Get, as: :get_by
  defdelegate get_by_old_token(token), to: Get, as: :get_by_old_token
  defdelegate get_all(), to: Get, as: :get_all
  defdelegate create(params), to: Create, as: :call
  defdelegate update(tokens, params), to: Update, as: :call
end
