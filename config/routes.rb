Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "posts#index"
  get '/search', to: "users#search"

  resources :users, only: [:show]

  resources :posts, except: [:edit, :update] do
    resources :comments, only: [:new, :create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :friendships, only: [:create, :update, :destroy]
  get '/pending', to: 'friendships#pending', as: 'pending_friendships'
end
