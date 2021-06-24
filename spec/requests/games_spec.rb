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
        "language": 'fr',
        "player_name": 'David',
        "game_mode": '1',
        "board_size": '3',
        "symbol": 'X'
      }
    end
    it 'returns success response' do
      post '/games', params: game_params, as: :json
      expect(response).to have_http_status(:created)
    end

    it 'creates a new game record' do
      expect { post '/games', params: game_params, as: :json }.to change { Game.count }.by(1)
    end
  end

  describe '#play' do
    let(:play_params) do
      {
        "move": '1',
        "current_board": [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
      }
    end

    it 'returns play ongoing if not finished' do
      put '/games/1/play', params: play_params, as: :json
      expect(response.parsed_body['state']).to eq('Ongoing')
    end

    it 'returns draw message if the game is tied' do
      play_params['current_board'] = [
        %w[- O X],
        %w[X X O],
        %w[O X O]
      ]
      put '/games/1/play', params: play_params, as: :json

      expect(response.parsed_body['state']).to eq("It's a draw")
    end
  end
end
