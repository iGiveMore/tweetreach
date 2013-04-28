Tweetreach::Application.routes.draw do
  resources :users

  get '/auth/:provider/callback', to: 'sessions#create'
 
  match 'profile' => 'home#profile'
  match 'home' => 'home#index'
  
  root :to => 'users#index'
end
