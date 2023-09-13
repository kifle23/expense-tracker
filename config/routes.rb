Rails.application.routes.draw do
  devise_for :users
  resources :categories, only: [:index, :new, :create, :destroy] do
    resources :records, only: [:index, :new, :create]
  end
  root "categories#index"
end
