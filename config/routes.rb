Rails.application.routes.draw do
  get 'users/new', to: 'users#new'
  post 'users/new', to: 'users#create'

  root 'menus#home'
  get '/about', to: 'menus#about'
  get 'regist', to: 'users#new'
  post 'regist', to: 'users#create'
  resources :users
end
