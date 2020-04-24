Rails.application.routes.draw do
  root 'menus#home'
  get '/about', to: 'menus#about'
  get 'regist', to: 'users#new'
  post 'regist', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
end
