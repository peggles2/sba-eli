class EnrollsController < ApplicationController
  before_action :valid_session?

  def create
    response = Canvas::LearningPath.enroll(params[:learning_path_id], Current.user)
    render json: response
  end
end
