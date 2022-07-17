Rails.application.routes.draw do
  resources :teams
  resources :users
  root 'homes#index'

  get '/power_rankings/years', to: 'power_rankings#years'
  get '/power_rankings/:year/weeks', to: 'power_rankings#weeks'

  resources :power_rankings, except: [:index] do
    resources :rankings
    resources :rankings do
      member do
        patch :drag
      end
    end
  end

  # patch 'drag/drag'

  # Sessions
  get '/sign_in', to:'sessions#new', as: 'sign_in'
  post '/sign_in', to: 'sessions#create'
  get '/sign_up', to: 'sessions#sign_up'
  post '/sign_up', to: 'sessions#register'
  delete '/sign_out', to: 'sessions#destroy', as: 'sign_out'

  # Admin Console
  get '/admin_console', to: 'admins#index'
end
