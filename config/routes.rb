JotLocker::Application.routes.draw do
  match '/auth/:provider/callback' => 'authentications#create'
  match "jots" => "jots#index"
  match "users/edit" => 'users#edit'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  match "users/:email" => 'users#index'
  match "users/index" => 'users#index'
  resources :intro
  match "courses/one" => 'courses#one'
  resources :courses do
    resources :jots
  end

  root :to => "intro#index"

end
