Rails.application.routes.draw do
  get 'sessions/new'

  resources :microposts do
    member do
      post 'retweet'
    end
  end
  
  resources :users do
    # users/1/following_users
    # users/1/follower_users
    member do
      get 'following_users'
      get 'follower_users'
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  get 'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root to: "static_pages#home"
end
