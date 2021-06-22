class Game < ApplicationRecord
  validates :language, presence: true
  validates :player_name, presence: true
  validates :game_mode, presence: true
  validates :board, presence: true
  validates :symbol, presence: true
end
