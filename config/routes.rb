Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
    end
  end
  post '/users/:user_id/posts/:id/like', to: 'likes#create'
  post '/users/:user_id/posts/:id/create_comment', to: 'comments#create'
end
