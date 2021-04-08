# frozen_string_literal: true

Rails.application.routes.draw do
  resources :batches, only: %i[index show] do
    resources :transactions, only: %i[edit update]
  end
  resources :planning_center_people
  resources :donors
  devise_for :users, path: '/', path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out',
    password: 'password',
    confirmation: 'confirmation',
    unlock: 'unlock',
    registration: 'register',
  }

  get '/privacy', to: 'welcome#privacy'
  get '/terms', to: 'welcome#terms'
  root to: 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
