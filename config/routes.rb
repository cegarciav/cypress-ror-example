Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/login', to: 'users#login'
  post '/users/check-credentials', to: 'users#check_credentials'
end
