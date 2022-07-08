Rails.application.routes.draw do
  resources :users
  root 'homes#index'

  resources :power_rankings, except: [:index] do
    resources :rankings do
      member do
        patch :move
      end
    end
  end

  # Sessions
  get '/sign_in', to:'sessions#new', as: 'sign_in'
  post '/sign_in', to: 'sessions#create'
  get '/sign_up', to: 'sessions#sign_up'
  post '/sign_up', to: 'sessions#register'
  delete '/sign_out', to: 'sessions#destroy', as: 'sign_out'

  # Admin Console
  get '/admin_console', to: 'admins#index'
end
