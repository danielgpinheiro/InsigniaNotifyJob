defmodule InsigniaNotifyJobWeb.Http.GetInsigniaData do
  alias InsigniaNotifyJobWeb.Http.Api

  def get(insignia_url) do
    Api.get(insignia_url)
  end
end
