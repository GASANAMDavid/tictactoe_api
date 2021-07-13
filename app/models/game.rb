# frozen_string_literal: true

class Game < ApplicationRecord
  validates :language, presence: true
  validates :player_name, presence: true
  validates_inclusion_of :game_mode, in: 1..2, presence: true
  validates :game_mode, presence: true
  validates :board, presence: true
  validates :symbol, presence: true
end
