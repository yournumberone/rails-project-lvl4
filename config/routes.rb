# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#show'
    resource :home, only: :show

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'sign_in', to: 'auth#new'
    delete 'sign_out', to: 'auth#destroy'

    resources :repositories
  end
end
