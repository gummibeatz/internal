Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users,
    skip: [:registrations, :passwords],
    controllers: { :omniauth_callbacks => "users#omniauth_callbacks" }

  resources :developers do
    collection { post :import }
  end

  post '/exit_tickets/create', to: 'exit_tickets#create'
  resources :exit_tickets
  # get '/exit_tickets/:id', to: 'exit_tickets#show', as: 'exit_ticket'

  resources :cohorts

end
