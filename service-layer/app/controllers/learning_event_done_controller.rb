class LearningEventDoneController < ApplicationController
  before_action :valid_session?

  def update
    Rails.logger.info "Learning Path: #{params[:learning_path_id]}"
    Rails.logger.info "Learning Objective: #{params[:learning_objective_id]}"
    Rails.logger.info "Learning Event: #{params[:id]}"
    Rails.logger.info Current.user.id

    response = Canvas::LearningEvent.done(params[:learning_path_id],
                                  params[:learning_objective_id],
                                  params[:id])
    render json: response
  end
end
