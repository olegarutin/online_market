Rails.application.routes.draw do
  root 'markets#index'

  devise_for :users

  resources :carts, only: :show
  resources :orders
  resource :line_items, except: :show
  resources :markets, :categories, only: %i[index show]
  resources :products, only: :index
end
