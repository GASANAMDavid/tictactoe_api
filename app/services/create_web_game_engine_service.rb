require 'TicTacToe'

class CreateWebGameEngineService < ApplicationService
  attr_reader :game_record

  def initialize(game_record)
    @game_record = game_record
  end

  def call
    opponent_player = TicTacToe::OpponentType.when_game_mode_is(game_record.game_mode)
    TicTacToe::WebEngine.new(game_record.board, game_record.player_name, opponent_player)
  end
end
