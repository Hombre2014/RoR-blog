Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show,]
  end
  get '/posts/new', to: 'posts#new'
  post '/posts/create', to: 'posts#create'
end
