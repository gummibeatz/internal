Rails.application.routes.draw do
  devise_for :users,
    skip: [:registrations, :passwords],
    controllers: { :omniauth_callbacks => "users#omniauth_callbacks" }

  root 'welcome#index'
end
