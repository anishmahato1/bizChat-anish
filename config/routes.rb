Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, only: :show

  get 'search', to: 'users#search'

  resources :channels, except: %i[index show] do
    get '/users', to: 'participants#index', as: :participants
    post 'users/:id', to: 'participants#add', as: :add_participants
    delete '/users/:id', to: 'participants#remove', as: :remove_participants
    get 'search', to: 'participants#search'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :chats, only: %i[index show] do
    resources :messages, only: :create
  end
  # Defines the root path route ("/")
  root to: 'chats#index'
end
