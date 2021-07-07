require 'TicTacToe'
require 'rails_helper'

RSpec.describe PlayGameService do
  let(:game) { create(:game) }
  let(:game_engine) { instance_double(TicTacToe::WebEngine) }
  before do
    allow(game_engine).to receive(:board).and_return([['X', '-', '-'], ['-', '-', '-'], ['-', '-', '-']])
  end
  it 'places the player move to the board' do
    expect(game_engine).to receive(:play).with('X', 1)
    described_class.new(game_engine, game).call(1)
    expect(game.board[0][0]).to eq 'X'
  end

  it 'raise an error if move is invalid' do
    expect(game_engine).to receive(:play).with('X', 1)
    expect(game_engine).to receive(:play).with('X', 1).and_raise(TicTacToe::InvalidMove, 'Invalid move')
    play_game = described_class.new(game_engine, game)
    play_game.call(1)
    expect { play_game.call(1) }.to raise_error(TicTacToe::InvalidMove)
  end
end
