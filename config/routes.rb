Rails.application.routes.draw do
  get 'users/show'
  get 'categories/show'
  root "items#index"
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :items do
    resources :orders, only: [:index, :create]
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :categories, only: [:index,:show]
  resources :users, :only => [:show]
end
