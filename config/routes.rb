Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users,
    skip: [:registrations, :passwords],
    controllers: {
      omniauth_callbacks: "users#omniauth_callbacks",
      sessions: "sessions"
    }

  resources :developers do
    collection { post :import }
  end

  get '/exit_tickets/report', to: 'exit_tickets#report'
  post '/exit_tickets/create', to: 'exit_tickets#create'
  post '/exit_tickets/import', to: 'exit_tickets#import'
  post '/exit_tickets/grade', to: 'exit_tickets#grade'

  post '/attendances/create', to: 'attendances#create'
  post '/attendances/import', to: 'attendances#import_all'

  resources :exit_tickets do
    collection { post :upload }
  end

  resources :units, only: [:show]

  resources :cohorts

  resources :reports, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :developers, only: [:show]
    end
  end

end
