Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  root to: 'visitors#index'
  # root to: "home#index"
  get '/users/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/users/auth/failure' => 'sessions#failure'
  post '/stories' => 'stories#create'
  get '/stories/:kinja_id' => 'stories#show'
  get '/:domain/:feed_type' => 'stories#index',
    :constraints => { :domain => /[^\/]+/ }
end
