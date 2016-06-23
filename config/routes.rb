Rails.application.routes.draw do

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  get "signup" => "users#new"

  resources :users do
    resources :requests, except: [:show, :update, :edit]
    resources :marks, only: [:index, :update]
  end
  resources :follows, only: [:create, :destroy]
  resources :books, only: [:index, :show] do
    resources :reviews, except: [:show, :index, :new]
    resources :marks, only: [:create, :update]
  end
  namespace :admin do
    root "users#index"
    resources :users, only: [:index, :destroy]
    resources :requests, only: [:index, :destroy]
    resources :books, except: :show
  end
end
