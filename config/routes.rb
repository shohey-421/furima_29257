Rails.application.routes.draw do
  get 'categories/show'
  root "items#index"
  devise_for :users
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: :create
  end
  resources :categories, only: [:show]
end
