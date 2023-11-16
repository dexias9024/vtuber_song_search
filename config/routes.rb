Rails.application.routes.draw do
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index show edit update destroy]
    resources :vtubers, only: %i[new create index show edit update destroy]
    resources :instruments, only: %i[new create]
    resources :members, only: %i[new create]
    resources :songs, only: %i[new create index show edit update destroy]
  end

  root 'guide#about'
  resources :users, only: %i[new create show edit update] do
    resources :user_favorites
  end
  get '/login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  post '/guest_login', to: 'user_sessions#guest_login'

  resources :vtubers, only: %i[show index]
  resources :songs, only: %i[new create index show edit update destroy] do
    resources :comments
  end
  resources :inqueries
  get '/request', to: 'user_requests#new'
  post '/request', to: 'user_requests#create'

  get '/about', to: 'guide#about'
  get '/terms', to: 'guide#terms'
  get '/privacy_policy', to: 'guide#privacy_policy'
end
