Rails.application.routes.draw do
  resources :users
  root 'homes#index'

  resources :power_rankings
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
