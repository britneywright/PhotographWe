Rails.application.routes.draw do
  root 'static_pages#index'

  resources :users, path_names: { new: 'signup' }

  resources :albums do
    resources :photographs do
      collection do
        get 'upload' => 'photographs#upload'
        patch 'add' => 'photographs#add'
      end
    end
  end
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#logout'
end
