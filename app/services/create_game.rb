# frozen_string_literal: true

class CreateGame
  attr_reader :game_params, :board_size

  def initialize(game_params, board_size)
    @game_params = game_params
    @board_size = board_size
  end

  def call
    board = TicTacToe::GameSetUp.create_board(board_size)
    Game.new(game_params.merge(board: board.board))
  end
end
