require 'rails_helper'

RSpec.describe GamesController do
  describe '#index' do
    it 'returns success rensponse' do
      get '/games'
      expect(response).to have_http_status(:ok)
    end
  end
  describe '#create' do
    let(:game_params) do
      {
        language: 'en',
        player_name: 'David',
        symbol: 'X',
        board_size: 3,
        game_mode: 1
      }
    end
    it 'returns success response' do
      post '/games', params: game_params
      expect(response).to have_http_status(:created)
    end

    it 'creates a new game record' do
      expect { post '/games', params: game_params }.to change { Game.count }.by(1)
    end
  end
end
