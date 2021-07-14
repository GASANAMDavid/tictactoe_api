class TranslationsController < ApplicationController
    def index
        json_response(TicTacToe::SetLanguages.language_translations(params[:language]))
    end
end
