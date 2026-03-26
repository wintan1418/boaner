Rails.application.routes.draw do
  # Admin
  namespace :admin do
    get "/", to: "dashboard#index"
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    resources :videos
    resources :posts
    resources :courses do
      resources :lessons, except: [ :index ]
    end
    resources :books
    resources :comments, only: [ :index, :update, :destroy ]
    resources :subscribers, only: [ :index, :destroy ]
    resource :settings, only: [ :edit, :update ] do
      post :sync_youtube, on: :member
    end
  end

  root "home#index"

  resources :videos, only: [ :index, :show ] do
    resources :comments, only: :create, module: :videos
  end

  resources :posts, only: [ :index, :show ], path: "blog" do
    resources :comments, only: :create, module: :posts
  end

  resources :courses, only: [ :index, :show ] do
    resources :lessons, only: :show
  end

  resources :books, only: :index
  resources :subscribers, only: :create

  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  post "contact", to: "pages#send_message"

  get "up" => "rails/health#show", as: :rails_health_check
end
