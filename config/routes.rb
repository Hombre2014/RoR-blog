Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]
  end
  post '/users/:user_id/posts/:id/like', to: 'likes#create'
  post '/users/:user_id/posts/:id/create_comment', to: 'comments#create'
end
