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
        "player_name": 'Gasana',
        "game_mode": 2,
        "board_size": 3,
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
    let(:find_game) { instance_double(FindGameService) }
    let(:create_game_engine) { instance_double(CreateWebGameEngineService) }
    let(:web_engine) { instance_double(TicTacToe::WebEngine) }
    let(:game_params) do
      {
        "language": 'fr',
        "player_name": 'Manzi',
        "game_mode": 2,
        "board_size": 3,
        "symbol": 'X'
      }
    end
    let(:game) { create(:game) }
    it 'returns game state after applying move' do
      put "/games/#{game.id}/play", params: { "move": 1 }, as: :json
      expect(response.parsed_body['state']).to eq('Ongoing')
    end

    describe 'Validations' do
      it 'validates the game id' do
        id = 0
        put "/games/#{id}/play", params: { "move": 1 }, as: :json
        expect(response.parsed_body['errors']).to eq("Couldn't find Game with 'id'=#{id}")
      end

      it 'validates the player move' do
        put "/games/#{game.id}/play", params: { "move": 10 }, as: :json
        expect(response.parsed_body['errors']).to eq('Invalid move')
      end
    end
  end
end
