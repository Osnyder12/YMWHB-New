Rails.application.routes.draw do
  root 'homes#index'

  resources :power_rankings
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
