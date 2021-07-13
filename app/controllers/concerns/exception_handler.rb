# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ "errors": e.message }, :not_found)
    end

    rescue_from TicTacToe::InvalidMove do |e|
      json_response({ "errors": e.message }, :unprocessable_entity)
    end
  end
end
