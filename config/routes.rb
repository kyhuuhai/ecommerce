Rails.application.routes.draw do
  resources :chat_rooms, only: [:new, :create, :show, :index]
  root 'home#index'
  devise_for :users
  resources :products
  resources :categories
  resources :carts
  resources :cart_details
  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messes, only: [:create]
  end

  mount ActionCable.server => '/cable'
end
