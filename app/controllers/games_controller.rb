require 'TicTacToe'

class GamesController < ApplicationController
  def index
    render json: { status: 'success' }
  end

  def create
    SetLanguages.change_language(params[:lang])
    render json: { status: 'success' }
  end
end
