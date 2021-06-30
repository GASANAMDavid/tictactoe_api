require 'swagger_helper'

RSpec.describe 'api/games', type: :request do
  path '/games' do
    post 'Create a new game' do
      tags 'games'
      consumes 'application/json'
      parameter name: :game, in: :body, schema: {
        type: :object,
        properties: {
          player_name: { type: :string },
          symbol: { type: :string },
          game_mode: { type: :integer },
          language: { type: :string },
          board_size: { type: :integer }
        },
        required: %w[player_name game_mode language board_size symbol]
      }
      response '201', 'blog created' do
        let(:game) { { player_name: 'Manzi', symbol: 'X', game_mode: 2, language: 'en', board_size: 3 } }
        run_test!
      end

      response '204', 'invalid request' do
        let(:game) { { player_name: 'David', game_mode: 2, language: 'en', board_size: 3 } }
        run_test!
      end
    end
  end

  # post '/games', params: game_params, as: :json

  describe '#play' do
    let(:game_params) do
      {
        "language": 'fr',
        "player_name": 'David',
        "game_mode": '2',
        "board_size": '3',
        "symbol": 'X'
      }
    end
    before do
      post '/games', params: game_params, as: :json
      id = response.parsed_body['id']
    end
    path "/games/1/play" do
      put 'Plays the game registered on a record with id 1' do
        produces 'application/json'
        consumes 'application/json'
        parameter name: :move, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :string, in: :path },
            move: { type: :string, in: :body }
          },
          required: %w[id move]
        }
        response '201', 'move applied' do
          let(:move) { { move: 1 } }
          run_test!
        end
      end
    end
  end
end
