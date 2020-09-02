Rails.application.routes.draw do
  get 'categories/show'
  root "items#index"
  devise_for :users
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :categories, only: [:index,:show]
end
