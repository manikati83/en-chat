Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'nickname', to: 'nicks#new'
  post 'nickname', to: 'nicks#create'
  
  get 'chat', to: 'messages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  
  get 'signup', to: 'users#new'
  
  resources :users, only: [:show, :create]
  resources :words, only: [:create, :destroy]
end
