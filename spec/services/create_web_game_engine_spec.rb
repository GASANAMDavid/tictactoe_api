require 'tictactoe'
require 'rails_helper'

RSpec.describe CreateWebGameEngine do
  let(:game_record) { create(:game) }
  let(:subject) { CreateWebGameEngine.new(game_record) }

  it 'return a game engine from the gem' do
    expect(subject.call).to be_a(TicTacToe::WebEngine)
  end
end
