Rails.application.routes.draw do
  # Admin
  namespace :admin do
    get "/", to: "dashboard#index"
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    get "forgot-password", to: "passwords#new"
    post "forgot-password", to: "passwords#create"
    get "reset-password", to: "passwords#edit"
    patch "reset-password", to: "passwords#update"
    resources :videos
    resources :posts
    resources :courses do
      resources :lessons, except: [ :index ]
    end
    resources :books
    resources :comments, only: [ :index, :update, :destroy ]
    resources :subscribers, only: [ :index, :destroy ]
    resources :contact_messages, only: [ :index, :show, :destroy ]
    resources :newsletters, except: [ :show ] do
      post :send_newsletter, on: :member
    end
    resources :series
    get "guide", to: "guide#index"
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

  resources :series, only: [:index, :show]
  resources :books, only: :index
  resources :subscribers, only: :create

  get "search", to: "search#index"
  get "feed", to: "feeds#index", defaults: { format: :rss }

  get "reading-list", to: "pages#reading_list"
  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  post "contact", to: "pages#send_message"

  get "up" => "rails/health#show", as: :rails_health_check
end
