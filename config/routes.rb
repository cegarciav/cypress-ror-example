Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'articles#index'

  # Users
  get '/login', to: 'users#login'
  get '/signup', to: 'users#signup'
  post '/users', to: 'users#create'
  post '/users/check-credentials', to: 'users#check_credentials'

  # Articles
  get '/articles/new', to: 'articles#new'
  post '/articles', to: 'articles#create'
end
