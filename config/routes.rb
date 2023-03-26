# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[create] do
    post :login, on: :collection
  end
  resources :jobs, only: %i[create index]
  resources :job_applications, only: %i[create]
end
