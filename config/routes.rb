Rails.application.routes.draw do
  root 'menus#home'
  get '/about', to: 'menus#about'

end
