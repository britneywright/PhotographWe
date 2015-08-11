Rails.application.routes.draw do
  root 'static_pages#index'

  resources :users
  resources :albums
  
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#logout'
end
