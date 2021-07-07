require 'TicTacToe'

class GamesController < ApplicationController
  # before_action :set_game, only: [:play]

  def index
    render json: { status: 'success' }
  end

  def create
    game = CreateGameService.call(game_params, params[:board_size])
    if game.valid?
      game.save
      json_response(game, :created)
    else
      json_response({ "errors": game.errors }, :unprocessable_entity)
    end
  end

  def play
    engine = CreateWebGameEngineService.call(current_game)
    PlayGameService.new(engine, current_game).call(params[:move].to_i)
    json_response(get_response(engine, current_game))
  end

  GAME_PARAMS = %i[language player_name symbol game_mode].freeze

  private

  def game_params
    params.require(:game).permit(GAME_PARAMS)
  end

  def get_response(engine, game_record)
    response = {
      state: 'Ongoing'
    }
    result = engine.check_status(game_record.symbol)
    response[:state] = result unless result.nil?
    response[:board] = game_record.board
    response
  end

  def current_game
    @current_game ||= Game.find(params[:id])
  end
end
