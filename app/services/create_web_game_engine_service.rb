# frozen_string_literal: true

require 'tictactoe'

class CreateWebGameEngineService
  attr_reader :game_record

  def initialize(game_record)
    @game_record = game_record
  end

  def call
    TicTacToe::WebEngine.new(game_record.board, game_record.player_name, game_record.game_mode)
  end
end
