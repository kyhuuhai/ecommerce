Rails.application.routes.draw do
  resources :chat_rooms, only: [:new, :create, :show, :index]
  root 'products#index'
  devise_for :users
  resources :products
  resources :categories
  mount ActionCable.server => '/cable'
end
