Rails.application.routes.draw do
  root 'markets#index'

  devise_for :users

  resources :markets, only: %i[index show]
end
