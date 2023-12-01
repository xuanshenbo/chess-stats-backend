require 'net/http'
require 'json'

class ChessComService
  def get_all_games(username)

    all_games = {"games": []}

    current_year = Time.now.year
    current_month = Time.now.month

    (2022..current_year).each do |year|
      (1..12).each do |month|
        break if year == current_year && month > current_month

        games_for_month = get_games_by_month(username, "%02d" % month, year)
        all_games[:games] = all_games[:games] + games_for_month["games"]
      end
    end

    all_games
  end

  def get_games_by_month(username, month, year)
    url = "https://api.chess.com/pub/player/#{username}/games/#{year}/#{month}"

    uri = URI(url)
    response = Net::HTTP.get(uri)

    JSON.parse(response)
  end
end
