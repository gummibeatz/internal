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
  resources :exit_tickets

  post '/attendances/create', to: 'attendances#create'

  resources :cohorts

end
