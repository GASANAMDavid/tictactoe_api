require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#validation' do
    it { should validate_presence_of(:language) }
    it { should validate_presence_of(:player_name) }
    it { should validate_presence_of(:game_mode) }
    it { should validate_presence_of(:board) }
    it { should validate_presence_of(:symbol) }
  end
end