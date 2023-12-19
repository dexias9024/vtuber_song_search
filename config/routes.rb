Rails.application.routes.draw do
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index show edit update destroy]
    resources :vtubers, only: %i[new create index show edit update destroy]
    resources :instruments, only: %i[new create]
    resources :members, only: %i[new create index destroy]
    resources :songs, only: %i[new create index show edit update destroy]
    resources :comments, only: %i[index destroy]
    resources :inquiries, only: %i[index show destroy] do
      member do
        post :close
      end
    end
  end

  root 'guide#about'
  resources :users, only: %i[new create show edit update]
  get '/login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  post '/guest_login', to: 'user_sessions#guest_login'

  resources :vtubers, only: %i[show index]
  resources :songs, only: %i[new create index show edit update destroy] do
    resources :comments, only: %i[create destroy]
    resources :favorites, only: %i[create destroy]
    collection do
      get :favorites
    end
  end
  resources :requests, only: %i[new create] do
    collection do
      post 'vtuber_form'
      post 'song_form'
    end
  end
  
  resources :inquiries, only: %i[new create]

  get '/about', to: 'guide#about'
  get '/terms', to: 'guide#terms'
  get '/privacy_policy', to: 'guide#privacy_policy'
end
