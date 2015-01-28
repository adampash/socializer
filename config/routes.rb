Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  root to: 'visitors#index'
  get '/login_instructions' => 'visitors#login_instructions'
  get '/login_success' => 'visitors#login_success'
  get '/setup' => 'visitors#setup'
  # root to: "home#index"
  get '/login_check' => 'users#logged_in'
  get '/users/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/users/auth/failure' => 'sessions#failure'
  post '/stories' => 'stories#create'
  post '/stories/update_pub' => 'stories#update_pub'
  get '/stories/:kinja_id' => 'stories#show'
  get '/:domain/:feed_type' => 'stories#index',
    :constraints => { :domain => /[^\/]+/ }
end
