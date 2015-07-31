Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users,
    skip: [:registrations, :passwords],
    controllers: { :omniauth_callbacks => "users#omniauth_callbacks" }

  resources :developers do
    collection { post :import }
  end

  post '/exit_tickets/create', to: 'exit_ticket#create'

  resources :cohorts

end
