Rails.application.routes.draw do

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "signup" => "users#new"

  resources :users do
    resources :requests, only: [:index, :new, :create]
  end

  resources :books, only: [:index, :show]

  namespace :admin do
    root "users#index"
    resources :users, only: [:index, :destroy]
  end
end
