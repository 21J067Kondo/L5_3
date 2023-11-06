Rails.application.routes.draw do
  get 'titter/top'
  get 'login_page',to: 'titter#loginp'
  get 'regi_page',to: 'titter#regi'
  get 'logout',to: 'titter#logout'
  get 'new_profile', to: 'titter#new_profile'
  get 'new_tweet', to: 'titter#new'
  patch 'titter/profile'
  post 'titter/create'
  post 'titter/login'
  post 'titter/regist'
  post '/like', to: 'titter#like'
  post '/not_like', to: 'titter#not_like'
  get '/del_user', to: 'titter#acdel'
  post '/del_tweet', to: 'titter#twdel'
  root 'titter#top'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
