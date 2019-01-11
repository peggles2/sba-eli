Rails.application.routes.draw do
  concern :contentable do
    resource :custom_content
  end

  put "learning_paths/:learning_path_id/learning_objectives/"\
      ":learning_objective_id/learning_events/:id/done",
      to: "learning_event_done#update"

  resource :confirmation_code, only: :create
  resources :learning_events, concerns: :contentable
  resources :learning_paths, concerns: :contentable
  resources :learning_objectives, concerns: :contentable
  resource :search, only: :show
  resource :session, only: %I[create destroy]
  resource :sign_up, only: :create
  resources :users
  resource :discussion, only: :show
end
