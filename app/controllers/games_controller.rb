require 'TicTacToe'

class GamesController < ApplicationController
  def index
    render json: { status: 'success' }
  end

  def create
    board = TicTacToe::GameSetUp.create_board(params[:board_size].to_i)
    game = Game.new(game_params.merge(board: board.board))
    if game.valid?
      game.save
      render json: game, status: :created
    end
  end

  def play
    game_record = FindGameService.call(params[:id])
    engine = CreateWebGameEngineService.call(game_record)
    play_game(engine, game_record)
    render json: get_response(engine, game_record)
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
