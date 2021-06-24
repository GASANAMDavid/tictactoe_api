Rails.application.routes.draw do
  resources :games, only: %i[index create] do
    put :play, on: :member
  end
end