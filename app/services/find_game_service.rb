class FindGameService < ApplicationService
  attr_reader :game_id

  def initialize(game_id)
    @game_id = game_id
  end

  def call
    game = Game.find_by id: game_id
    raise StandardError, "Could not find Game with 'id'=#{game_id}" unless game.present?

    game
  end
end
