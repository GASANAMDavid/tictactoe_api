require 'rails_helper'

RSpec.describe "Translations", type: :request do
  describe "GET /index" do
    it 'returns :ok status code' do
      get '/translations/fr'
      expect(response).to have_http_status(:ok)
    end

    it 'raises an error if locale is invalid' do
      
      get '/translations/hello'
      expect(response.parsed_body['errors']).to eq('"hello" is not a valid locale')
    end

    it 'returns an object containing translations if locale is valid' do 
      get '/translations/fr'
      expect(response.parsed_body['welcomeMessage']).to eq('Bienvenue au Jeu de TicTac Orteil')
      expect(response.parsed_body['gameMode']).to eq('Mode de jeu')
    end
  end
end
