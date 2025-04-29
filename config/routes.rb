Rails.application.routes.draw do
  resource :registrations, only: [:new, :create]
  resource :session
  resources :passwords, param: :token
  resources :urls
  resources :links
  resources :link_kinds
  resources :edition_positions
  resources :edition_sections
  resources :editions
  resources :archetypes
  resources :artist_credit_participants
  resources :artist_credits
  resources :participants

  get "home", to: "home#index"
  resources :import_orders
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: [:index, :show, :destroy]
  resource :password, only: [:edit, :update]
  namespace :identity do
    resource :email, only: [:edit, :update]
    resource :email_verification, only: [:edit, :create]
    resource :password_reset, only: [:new, :edit, :create, :update]
  end
  root "main#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
