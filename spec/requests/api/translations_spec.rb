# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/translations', type: :request do
  path '/translations/{language}' do
    get 'retrives translations from the tictactoe gem used by the API given language choice' do
      produces 'application/json'
      consumes 'application/json'
      parameter name: :language, in: :path, type: :string
      response '200', 'translations available' do
        let(:language) { 'en' }
        run_test!
      end
    end
  end
end
