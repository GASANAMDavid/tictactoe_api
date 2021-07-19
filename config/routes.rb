# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :games, only: %i[index create] do
    put :play, on: :member
  end

  get 'translations/:language', to: 'translations#index'
end
