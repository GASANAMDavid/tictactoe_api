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
        "game_mode": '2',
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
        "move": '1'
      }
    end

    it 'returns play ongoing if not finished' do
      put '/games/1/play', params: play_params, as: :json
      expect(response.parsed_body['state']).to eq('Ongoing')
    end

    context 'tests if there is a draw' do
      let(:moves) do
        [{
          "move": '1'
        }, {
          "move": '4'
        }, {
          "move": '3'
        }, {
          "move": '8'
        }, {
          "move": '9'
        }]
      end
      it 'returns draw message if the game is tied' do
        moves.each do |play_params|
          put '/games/107/play', params: play_params, as: :json
        end
        expect(response.parsed_body['state']).to eq("It's a Draw")
      end
    end
    context 'tests if there is a winner' do
      let(:moves) do
        [{
          "move": '1'
        }, {
          "move": '2'
        }, {
          "move": '4'
        }]
      end
      it 'returns draw message if the game is tied' do
        moves.each do |play_params|
          put '/games/107/play', params: play_params, as: :json
        end
        expect(response.parsed_body['state']).to eq('Intelligent Computer won the game')
      end
    end
  end
end
