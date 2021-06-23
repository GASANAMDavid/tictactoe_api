require 'TicTacToe'

class GamesController < ApplicationController
  def index
    render json: { status: 'success' }
  end

  def create
    board = GameSetUp.create_board(params[:board_size].to_i)
    game = Game.new(game_params.merge(board: board.board))
    if game.valid?
      game.save
      render json: game, status: :created
    end
  end

  GAME_PARAMS = %i[language player_name symbol game_mode].freeze

  def game_params
    params.require(:game).permit(GAME_PARAMS)
  end
end
