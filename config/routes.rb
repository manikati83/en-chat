Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'nickname', to: 'nicks#new'
  post 'nickname', to: 'nicks#create'
  
  get 'chat', to: 'messages#index'
end
