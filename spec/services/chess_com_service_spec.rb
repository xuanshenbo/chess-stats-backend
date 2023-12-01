require 'rails_helper'
require 'net/http'
require 'json'

RSpec.describe ChessComService do
  describe '#get_all_games' do
    it 'returns all games for a given username' do
      service = ChessComService.new

      username = 'test_user'

      no_games = { 'games' => [] }
      allow(service).to receive(:get_games_by_month).and_return(no_games)

      games_for_jan = { 'games' => [{ 'id' => 1, 'result' => 'win' }] }
      url_jan = "https://api.chess.com/pub/player/#{username}/games/2023/01"
      uri_jan = URI(url_jan)

      allow(service).to receive(:get_games_by_month).with(username, "01", 2023).and_return(games_for_jan)

      games_for_feb = { 'games' => [{ 'id' => 2, 'result' => 'win' }] }
      url_feb = "https://api.chess.com/pub/player/#{username}/games/2023/02"
      uri_feb = URI(url_feb)

      allow(service).to receive(:get_games_by_month).with(username, "02", 2023).and_return(games_for_feb)

      all_games = service.get_all_games(username)

      expect(all_games).to be_a(Hash)
      expect(all_games[:games]).to be_an(Array)
      expect(all_games[:games].length).to be 2
    end
  end

  describe '#get_games_by_month' do
    it 'returns games for a given username, month, and year' do
      username = 'test_user'
      month = '01'
      year = '2022'
      response_body = { 'games' => [{ 'id' => 1, 'result' => 'win' }] }.to_json
      url = "https://api.chess.com/pub/player/#{username}/games/#{year}/#{month}"
      uri = URI(url)

      allow(Net::HTTP).to receive(:get).with(uri).and_return(response_body)

      service = ChessComService.new
      games = service.get_games_by_month(username, month, year)

      expect(games).to be_a(Hash)
      expect(games['games']).to be_an(Array)
      expect(games['games'].length).to be > 0
    end
  end
end
