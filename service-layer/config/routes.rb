Rails.application.routes.draw do
  resource :cofirmation_code, only: :create
  resources :learning_events
  resources :learning_paths
  resources :learning_objectives
  resource :session, only: %I[create destroy]
  resource :sign_up, only: :create
  resources :users
end
