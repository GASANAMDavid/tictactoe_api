Rails.application.routes.draw do
  resources :games, only: %i[index create update]
  put '/games/:id/play', controller: 'games', action: 'play'
end
