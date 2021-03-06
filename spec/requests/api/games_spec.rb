# frozen_string_literal: true

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
      response '201', 'game created' do
        let(:game) { { player_name: 'Manzi', symbol: 'X', game_mode: 2, language: 'en', board_size: 3 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:game) { { player_name: 'David', game_mode: 2, language: 'en', board_size: 3 } }
        run_test!
      end
    end
  end

  describe '#play' do
    path '/games/{id}/play' do
      put "Plays the game registered on a record with id #{id}" do
        produces 'application/json'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        parameter name: :move, in: :body, schema: {
          type: :object,
          properties: {
            move: { type: :string }
          },
          required: %w[move]
        }
        response '200', 'move applied' do
          let(:move) { { move: 9 } }
          let(:id) { FactoryBot.create(:game).id }
          run_test!
        end
      end
    end
  end

  describe '#reset' do
    path '/games/{id}/reset' do
      put "Resets the board of game registered on a record with id #{id}" do
        produces 'application/json'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        response '200', 'board reset' do
          let(:id) { FactoryBot.create(:game).id }
          run_test!
        end
      end
    end
  end
end
