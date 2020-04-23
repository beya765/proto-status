Rails.application.routes.draw do
  root 'menus#home'
  get '/about', to: 'menus#about'
  get 'regist', to: 'users#new'
  post 'regist', to: 'users#create'
  resources :users
end
