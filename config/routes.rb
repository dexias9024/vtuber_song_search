Rails.application.routes.draw do
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index show edit update destroy]
  end

  root 'guide#about'
  resources :users, only: %i[new create] do
    resources :user_favorites
  end
  get '/login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  post '/guest_login', to: 'user_sessions#guest_login'

  resources :songs do
    resources :comments
  end
  resources :inqueries
  get '/request', to: 'user_requests#new'
  post '/request', to: 'user_requests#create'

  get '/about', to: 'guide#about'
  get '/terms', to: 'guide#terms'
  get '/privacy_policy', to: 'guide#privacy_policy'
end
