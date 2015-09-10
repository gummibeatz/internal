Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users,
    skip: [:registrations, :passwords],
    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope path: '/admin', module: :admin do

    resources :units, only: [:show]
    resources :cohorts
    resources :reports, only: [:index]
    resources :exit_tickets do
      collection { post :upload }
    end
    resources :developers do
      collection { post :import }
    end

    resources :developers do
      collection { post :import }
    end

  end

  scope path: '/developers', module: :developers do
    get '/', to: "developers#index"
    get '/stats', to: "developers#stats"
  end

  namespace :api do
    namespace :v1 do
      get '/developer', to: 'developers#show'

      get '/attendances', to: 'attendances#index'
      post '/attendances/create', to: 'attendances#create'
      post '/attendances/import', to: 'attendances#import_all'

      post '/assessments/create', to: 'assessments#create'
      get '/assessments/', to: 'assessments#index'

      get '/developers', to: 'developers#show'

      get '/exit_tickets/report', to: 'exit_tickets#report'
      post '/exit_tickets/create', to: 'exit_tickets#create'
      post '/exit_tickets/import', to: 'exit_tickets#import'
      post '/exit_tickets/grade', to: 'exit_tickets#grade'
    end
  end

end
