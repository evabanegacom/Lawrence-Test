Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create index]
      post '/login', to: 'users#login'
      get '/auto_login', to: 'users#auto_login'
      delete '/logout', to: 'users#logout'
      get '/all_transactions', to: 'transacts#index'
      post '/add_money', to: 'transacts#add_money'
      post '/send_money', to: 'transacts#send_money'
    end
  end
  root to: 'static#index'
end
