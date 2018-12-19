Rails.application.routes.draw do
  concern :contentable do
    resource :custom_content
  end

  resource :cofirmation_code, only: :create
  resources :learning_events, concerns: :contentable
  resources :learning_paths, concerns: :contentable
  resources :learning_objectives, concerns: :contentable
  resource :search, only: :show
  resource :session, only: %I[create destroy]
  resource :sign_up, only: :create
  resources :users
end
