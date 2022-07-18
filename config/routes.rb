Rails.application.routes.draw do
  root 'markets#index'

  devise_for :users

  resources :carts, only: :show
  resource :line_items, except: :show
  resources :markets, :categories, only: %i[index show]
  resources :products, only: :index
end
