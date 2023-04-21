Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :chats
  get 'search', to: 'chats#search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'chats#index'
end
