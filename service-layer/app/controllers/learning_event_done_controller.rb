class LearningEventDoneController < ApplicationController
  before_action :valid_session?

  def update
    response = Canvas::LearningEvent.done(params[:learning_path_id],
                                  params[:learning_objective_id],
                                  params[:id])
    render json: response
  end
end
