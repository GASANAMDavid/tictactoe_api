class FindGameService < ApplicationService
  attr_reader :game_id

  def initialize(game_id)
    @game_id = game_id
  end

  def call
    Game.find(game_id)
  end
end
