Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :index] do
    post :login, on: :collection
  end
  resources :jobs, only: [:create, :index]
  resources :shifts, only: [:create, :index]
end
