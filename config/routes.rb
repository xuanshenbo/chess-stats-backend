Rails.application.routes.draw do
  get 'profile/:username', to: 'chess_com#profile'
  get 'stats/:username', to: 'chess_com#stats'
  get '/games_by_month/:username/:month/:year', to: 'chess_com#games_by_month', as: 'games_by_month'
  get '/all_games/:username', to: 'chess_com#all_games', as: 'all_games'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
