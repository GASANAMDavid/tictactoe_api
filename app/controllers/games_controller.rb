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

  def play
    # retrieve game from database with params[:id]
    # instantiate game engine from TTT gem
    # play the move on the game object
    # return the result
    response = {
      state: 'Ongoing'
    }
    game_record = Game.find(params[:id])
    symbol = game_record.symbol
    board_size = params[:current_board].length
    move = params[:move].to_i
    playing_board = Board.new(board_size)
    playing_board.board = params[:current_board]
    playing_board.apply_move(symbol, move)
    response[:state] = "It's a draw" if playing_board.board_state(symbol) == 'Tie'

    render json: response
  end

  GAME_PARAMS = %i[language player_name symbol game_mode].freeze

  private

  def game_params
    params.require(:game).permit(GAME_PARAMS)
  end
end
