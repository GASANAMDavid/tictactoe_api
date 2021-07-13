# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :games, only: %i[index create] do
    post :translate, on: :member
    put :play, on: :member
  end
end
