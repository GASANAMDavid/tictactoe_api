require 'rails_helper'

RSpec.describe GamesController do
  let(:game) { create(:game) }
  describe '#index' do
    it 'returns success rensponse' do
      get '/games'
      expect(response).to have_http_status(:ok)
    end
  end
  describe '#create' do
    let(:create_game) { instance_double(CreateGameService) }
    before do
      allow(create_game).to receive(:call).and_return(game)
    end
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
<<<<<<< HEAD
    let(:find_game) { instance_double(FindGameService) }
    let(:game_engine) { instance_double(CreateWebGameEngineService) }
=======
    let(:game) { create(:game) }
    let(:find_game) { instance_double(FindGameService) }
    let(:game_engine) { instance_double(CreateWebGameEngineService) }
    let(:engine) { instance_double(TicTacToe::WebEngine) }
>>>>>>> 8d4a796 (mocking out the services classes in tests)
    let(:play_params) do
      {
        "move": '1'
      }
    end
    let(:game_params) do
      {
        "language": 'fr',
        "player_name": 'Manzi',
        "game_mode": '2',
        "board_size": '3',
        "symbol": 'X'
      }
    end
    let(:game) { create(:game) }
    it 'returns play ongoing if not finished' do
      put "/games/#{game.id}/play", params: play_params, as: :json
      expect(response.parsed_body['state']).to eq('Ongoing')
    end

    context 'tests if there is a draw' do
      it 'returns draw message if the game is tied' do
        game.board = [['-', 'O', 'X'],
                      %w[X O O],
                      %w[O X X]]
        game.save
        put "/games/#{game.id}/play", params: { "move": '1' }, as: :json
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
      it 'returns winner message if the game is won' do
        moves.each do |play_params|
          put "/games/#{game.id}/play", params: play_params, as: :json
        end
        expect(response.parsed_body['state']).to eq('Intelligent Computer won the game')
      end
    end
  end
end
