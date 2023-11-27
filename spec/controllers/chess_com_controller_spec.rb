require 'rails_helper'
require 'net/http'
require 'json'

RSpec.describe ChessComController, type: :controller do
  describe '#profile' do
    it 'returns the profile data for a given username' do
      username = 'test_user'
      uri = URI("https://api.chess.com/pub/player/#{username}")
      response_body = { 'username' => username, 'rating' => 1500 }.to_json

      allow(Net::HTTP).to receive(:get).with(uri).and_return(response_body)

      get :profile, params: { username: username }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(response_body)
    end
  end

  describe '#stats' do
    it 'returns the stats data for a given username' do
      username = 'test_user'
      uri = URI("https://api.chess.com/pub/player/#{username}/stats")
      response_body = { 'username' => username, 'games' => 100 }.to_json

      allow(Net::HTTP).to receive(:get).with(uri).and_return(response_body)

      get :stats, params: { username: username }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(response_body)
    end
  end

  describe '#games_by_month' do
    it 'returns the games data for a given username, month, and year' do
      username = 'test_user'
      month = '01'
      year = '2022'
      uri = URI("https://api.chess.com/pub/player/#{username}/games/#{year}/#{month}")
      response_body = { 'username' => username, 'games' => 10 }.to_json

      allow(Net::HTTP).to receive(:get).with(uri).and_return(response_body)

      get :games_by_month, params: { username: username, month: month, year: year }

      expect(response).to have_http_status(:success)
      expect(response.body).to eq(response_body)
    end
  end
end
