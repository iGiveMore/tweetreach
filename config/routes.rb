Tweetreach::Application.routes.draw do
  resources :users

  get '/auth/:provider/callback', to: 'sessions#create'

  root :to => 'users#index'
end
