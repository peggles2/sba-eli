class LearningEventsController < ApplicationController
  def index
    @events = Canvas::LearningEvent.all(params[:course_id], params[:module_id])
    render json: @events, status: :ok
  end

  def show
    @event = Canvas::LearningEvent.find(params[:course_id], params[:module_id], params[:id])
    render json: @event, status: :ok
  end

  def update
    @event = Canvas::LearningEvent.update(
      params[:course_id],
      params[:module_id],
      params[:id],
      params, 
    )
    render json: @event, status: :ok
  end

  def destroy
    @event = Canvas::LearningEvent.destroy(params[:course_id], params[:module_id], params[:id])
    render json: @event, status: :ok
  end
end
