Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users,
    skip: [:registrations, :passwords],
    controllers: { :omniauth_callbacks => "users#omniauth_callbacks" }

  resources :developers do
    collection { post :import }
  end

  post '/exit_tickets/create', to: 'exit_tickets#create'
  post '/exit_tickets/import', to: 'exit_tickets#import'
  resources :exit_tickets do
    collection { post :upload }
  end

  post '/attendances/create', to: 'attendances#create'
  post '/attendances/import', to: 'attendances#import_all'

  resources :units, only: [:show]

  resources :cohorts

end
