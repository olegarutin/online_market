Rails.application.routes.draw do
  root 'markets#index'

  devise_for :users

  resources :carts, only: :show
  resources :orders, only: :index
  resource :line_items, except: :show
  resources :markets, :categories, only: %i[index show]
  resources :products, only: :index

  post 'checkout/create', to: 'checkout#create', as: 'checkout_create'
  get 'order/create', to: 'orders#create'
end
