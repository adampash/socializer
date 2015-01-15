Rails.application.routes.draw do
  devise_for :users
  # resources :users
  # root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  get '/:domain/:feed_type' => 'stories#index', :as => :stories,
    :constraints => { :domain => /[^\/]+/ }
  post '/stories' => 'stories#create'
end
