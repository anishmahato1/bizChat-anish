Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :chats
  get 'homepage/search', to: "homepage#search", as: :search
  get 'homepage/index', to: "homepage#index", as: :homepage
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'homepage#index'
end
