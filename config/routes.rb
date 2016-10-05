Rails.application.routes.draw do
  get 'sessions/new'

  resources :microposts
  resources :users
  resources :relationships, only: [:create, :destroy]
  
  get 'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root to: "static_pages#home"
end
