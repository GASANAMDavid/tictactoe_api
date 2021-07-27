# frozen_string_literal: true

require 'tictactoe'

class GamesController < ApplicationController
  def index
    render json: { status: 'success' }
  end

  def create
    game = CreateGame.new(game_params, params[:board_size].to_i).call
    if game.valid?
      game.save
      json_response(game, :created)
    else
      json_response({ errors: game.errors }, :unprocessable_entity)
    end
  end

  def play
    engine = CreateWebGameEngine.new(current_game).call
    PlayGame.new(engine, current_game).call(params[:move].to_i)
    json_response(get_response(engine, current_game))
  end

  def reset
    game = Game.find(params[:id])
    new_board = TicTacToe::GameSetUp.create_board(game.board.length).board
    game.board = new_board
    game.save
    json_response({ board: game.board })
  end

  GAME_PARAMS = %i[language player_name symbol game_mode].freeze

  private

  def game_params
    params.require(:game).permit(GAME_PARAMS)
  end

  def get_response(engine, game_record)
    response = {}
    response[:state] = engine.check_status(game_record.symbol)
    response[:board] = game_record.board
    response[:opponent] = engine.opponent_player.name
    response[:opponentSymbol] = engine.opponent_player.symbol
    response
  end

  def current_game
    @current_game ||= Game.find(params[:id])
  end
end
