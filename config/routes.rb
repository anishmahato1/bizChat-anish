Rails.application.routes.draw do
  resources :chats
  devise_for :users, controllers: { registrations: "users/registrations" }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'chats#index'
end
