class LearningPathsController < ApplicationController
  def index
    @learning_paths = Canvas::LearningPath.all
    render json: @learning_paths, status: :ok
  end

  def show
    @learning_path = Canvas::LearningPath.find(params[:id])
    render json: @learning_path, status: :ok
  end

  def create
    @learning_path = Canvas::LearningPath.create(params[:id], params)
    render json: @learning_path
  end

  def update
    @learning_path = Canvas::LearningPath.update(params[:id], params)
    render json: @learning_path
  end

  def destroy
    @learning_path = Canvas::LearningPath.destroy(params[:id])
    render json: @learning_path
  end

  def progress
    @learning_path = Canvas::LearningPath.check_progress(params[:id])
    render json: @learning_path
  end
end
