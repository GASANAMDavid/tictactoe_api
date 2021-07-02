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
        "player_name": 'Manzi',
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

    describe 'validations' do
      it 'validates missing parameters' do
        game_params[:player_name] = ''
        game_params[:symbol] = ''
        post '/games', params: game_params, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to eq({ 'player_name' => ["can't be blank"],
                                                       'symbol' => ["can't be blank"] })
      end

      it 'validates board size to be integer' do
        game_params[:board_size] = 'X'
        post '/games', params: game_params, as: :json
        expect(response.parsed_body['errors']).to eq('no implicit conversion of String into Integer')
      end

      it 'validates the game_mode to either be 1 or 2' do
        game_params[:game_mode] = 3
        post '/games', params: game_params, as: :json
        expect(response.parsed_body['errors']).to eq('game_mode' => ['is not included in the list'])
        game_params[:game_mode] = 2
        post '/games', params: game_params, as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe '#play' do
<<<<<<< HEAD
<<<<<<< HEAD
    let(:find_game) { instance_double(FindGameService) }
<<<<<<< HEAD
    let(:game_engine) { instance_double(CreateWebGameEngineService) }
<<<<<<< HEAD
=======
    let(:game) { create(:game) }
    let(:find_game) { instance_double(FindGameService) }
    let(:game_engine) { instance_double(CreateWebGameEngineService) }
    let(:engine) { instance_double(TicTacToe::WebEngine) }
>>>>>>> 8d4a796 (mocking out the services classes in tests)
=======
    let(:find_game) { instance_double(FindGameService) }
    let(:game_engine) { instance_double(CreateWebGameEngineService) }
>>>>>>> f4c5f3f (added CreateGameService)
    let(:play_params) do
      {
        "move": '1'
      }
    end
=======
=======
    let(:create_game_engine) { instance_double(CreateWebGameEngineService) }
>>>>>>> be5ae70 (descriptive naming)
    let(:web_engine) { instance_double(TicTacToe::WebEngine) }
>>>>>>> 9a02789 (added validation of all endpoints)
    let(:game_params) do
      {
        "language": 'fr',
        "player_name": 'Manzi',
        "game_mode": '2',
        "board_size": '3',
        "symbol": 'X'
      }
    end
<<<<<<< HEAD
    let(:game) { create(:game) }
    it 'returns play ongoing if not finished' do
      put "/games/#{game.id}/play", params: play_params, as: :json
=======
    before do
      post '/games', params: game_params, as: :json
      allow(create_game_engine).to receive(:call).and_return(web_engine)
      allow(find_game).to receive(:call).and_return(game)
    end

    it 'returns play ongoing if not finished' do
      id = response.parsed_body['id']
<<<<<<< HEAD
      put "/games/#{id}/play", params: {"move": 1}, as: :json
>>>>>>> 9a02789 (added validation of all endpoints)
=======
      put "/games/#{id}/play", params: { "move": 1 }, as: :json
>>>>>>> f55fbbd (validates the game mode to either ve <1> or <2>)
      expect(response.parsed_body['state']).to eq('Ongoing')
    end

    context 'tests if there is a draw' do
<<<<<<< HEAD
=======
      let(:moves) do
        [{
          "move": 1
        }, {
          "move": 4
        }, {
          "move": 3
        }, {
          "move": 8
        }, {
          "move": 9
        }]
      end
>>>>>>> 9a02789 (added validation of all endpoints)
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
          "move": 1
        }, {
          "move": 2
        }, {
          "move": 4
        }]
      end
      it 'returns winner message if the game is won' do
        moves.each do |play_params|
          put "/games/#{game.id}/play", params: play_params, as: :json
        end
        expect(response.parsed_body['state']).to eq('Intelligent Computer won the game')
      end
    end

    describe 'Validations' do
      it 'validates the game id' do
        id = 0
        put "/games/#{id}/play", params: { "move": 1 }, as: :json
        expect(response.parsed_body['errors']).to eq("Could not find Game with 'id'=#{id}")
      end

      it 'validates the player move' do
        id = response.parsed_body['id']
        put "/games/#{id}/play", params: { "move": 10 }, as: :json
        expect(response.parsed_body['errors']).to eq('Invalid move')
      end
    end
  end
end
