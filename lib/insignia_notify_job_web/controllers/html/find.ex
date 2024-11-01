defmodule InsigniaNotifyJobWeb.Html.Find do
  alias InsigniaNotifyJobWeb.Http.HandleResponse
  alias InsigniaNotifyJobWeb.Html.Parse

  def find_games_row({:ok, html}, games_table_rows_selector) do
    Floki.find(html, games_table_rows_selector)
    |> Enum.map(fn row -> Parse.parse_games_row(row) end)
  end

  def find_games_row({:error, reason}, _),
    do: HandleResponse.response(:error, reason)

  def find_insignia_stats({:ok, html}, stats_selector) do
    Floki.find(html, stats_selector)
    |> Parse.parse_stats()
  end

  def find_insignia_stats({:error, reason}, _),
    do: HandleResponse.response(:error, reason)

  def find_game_matches({:ok, html}, selector) do
    Floki.find(html, selector)
    |> Parse.parse_game_matches()
  end

  def find_game_matches({:error, reason}, _),
    do: HandleResponse.response(:error, reason)

  def find_game_playlists({:ok, html}, selector) do
    Floki.find(html, selector)
    |> Parse.parse_game_playlists()
  end

  def find_game_playlists({:error, reason}, _),
    do: HandleResponse.response(:error, reason)
end
