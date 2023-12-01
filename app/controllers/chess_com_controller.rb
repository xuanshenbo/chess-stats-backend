require 'net/http'
require 'json'

class ChessComController < ApplicationController
  def profile
    @username = params[:username]
    uri = URI("https://api.chess.com/pub/player/#{@username}")

    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    render json: data
  end

  def stats
    @username = params[:username]
    uri = URI("https://api.chess.com/pub/player/#{@username}/stats")

    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    render json: data
  end

  def games_by_month
    @username = params[:username]
    @month = params[:month]
    @year = params[:year]
    uri = URI("https://api.chess.com/pub/player/#{@username}/games/#{@year}/#{@month}")

    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    render json: data
  end

  def all_games
    @username = params[:username]
    chess_com_service = ChessComService.new
    data = chess_com_service.get_all_games(@username)
    render json: data
  end
end
