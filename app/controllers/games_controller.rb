require 'TicTacToe'

class GamesController < ApplicationController
  def index
    render json: { status: 'success' }
  end

  def create
    game = CreateGameService.call(game_params, params[:board_size].to_i)
    if game.valid?
      game.save
      render json: game, status: :created
    end
  end

  def play
    response = {
      state: 'Ongoing',
      board: params[:current_board]
    }
    game_record = Game.find(params[:id])
    opponent_player = TicTacToe::OpponentType.when_game_mode_is(game_record.game_mode)
    engine = TicTacToe::WebEngine.new(game_record.board, game_record.player_name, opponent_player)
    engine.play(game_record.symbol, params[:move].to_i)
    game_record.board = engine.board
    game_record.save
    result = engine.check_status(game_record.symbol)
    response[:state] = result unless result.nil?
    response[:board] = engine.board
    render json: response
  end

  GAME_PARAMS = %i[language player_name symbol game_mode].freeze

  private

  def game_params
    params.require(:game).permit(GAME_PARAMS)
  end

  def play_game(engine, game_record)
    engine.play(game_record.symbol, params[:move].to_i)
    game_record.board = engine.board
    game_record.save
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
end
