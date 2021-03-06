Rails.application.routes.draw do
  get   '/notifications/:token/unsubscribe', to: 'notifications#unsubscribe', as: :notification_unsubscribe
  get   '/notifications/:token/cancel', to: 'notifications#cancel', as: :notification_cancel
  get   '/notifications/:token/ignore', to: 'notifications#ignore', as: :notification_ignore
  get   '/notifications/:token/read', to: 'notifications#read', as: :notification_read
  get   '/notifications/:token/view', to: 'notifications#view', as: :notification_view
  get   '/notifications/:token', to: 'notifications#click', as: :notification_click
  get   '/notifications/recent', to: 'notifications#recent', as: :notifications_recent
  root 'welcome#index'

  get 'events', to: 'events#index'

  devise_for :users,
    skip: [:registrations, :passwords],
    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope path: '/admin', module: :admin do

    resources :units, only: [:show]
    resources :cohorts
    resources :reports, only: [:index]
    resources :evaluations, only: [:index]
    resources :exit_tickets do
      collection { post :upload }
    end
    resources :developers do
      collection { post :import }
    end

    resources :developers do
      collection { post :import }
    end

    resources :equipments

  end

  scope path: '/developers', module: :developers do
    get '/', to: "developers#index"
    get '/stats', to: "developers#stats"
    get '/slack', to: "developers#slack"
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

      get '/equipments', to: 'equipments#index'

      get '/slackAPI', to: 'slack_api#index'

      get '/exit_tickets/report', to: 'exit_tickets#report'
      post '/exit_tickets/create', to: 'exit_tickets#create'
      post '/exit_tickets/import', to: 'exit_tickets#import'
      post '/exit_tickets/grade', to: 'exit_tickets#grade'

      post '/bash2015', to: 'events#bash2015_receive_message'
      get '/bash2015', to: 'events#bash_2015'

      get '/evaluations', to: 'evaluations#index'
      post 'evaluations/create', to: 'evaluations#create'
    end
  end

end
