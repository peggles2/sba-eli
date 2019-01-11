class EnrollsController < ApplicationController
  before_action :valid_session?

  def create
    enroll_response = Canvas::LearningPath.enroll(params[:learning_path_id], Current.user)
    path_response = Canvas::LearningPath.find(params[:learning_path_id])
    topics_response = Canvas::LearningObjective.all(params[:learning_path_id])
    
    render json: { "enrollment": enroll_response, "learningPath": path_response, "topicsList": topics_response }
  end
end
