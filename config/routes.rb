# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    resources :checks, only: :create
  end

  scope module: :web do
    root 'home#show'
    resource :home, only: :show

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    resources :auth, only: %i[new destroy]

    resources :repositories do
      scope module: :repositories do
        resources :checks
      end
    end
  end
end
