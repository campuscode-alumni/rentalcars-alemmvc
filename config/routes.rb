Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_models, only: %i[show new create edit index update]
  resources :subsidiaries, only: %i[show new create edit index update] do
    member do
      get 'rental_price', to: 'rental_prices#new'
      post 'rental_price', to: 'rental_prices#create'
    end
  end
  resources :insurances, only: %i[index new create]
  resources :cars, only: %i[show new create]
  resources :manufactures, only: %i[new create show edit update index]
  resources :rental_prices, only: %i[index]
  resources :fuel_type, only: %i[show new create]
  resources :clients, only: %i[show new create]
  resources :individual_clients, only: %i[show new create index edit update]
  resources :corporate_clients, only: %i[show new create index edit update]
  resources :categories, only: %i[index new create edit update]
  resources :rentals, only: %i[index new create show] do
    get 'search', on: :collection
    member do
      get 'review'
      post 'confirm'
      post 'start'
      post 'finish'
    end
  end

  resources :addons, only: %i[index new create edit update]
end
