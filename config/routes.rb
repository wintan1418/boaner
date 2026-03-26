Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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
