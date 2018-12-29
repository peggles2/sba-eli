class QuizzesController < ApplicationController
  def index
    @quizzes = Canvas::Quiz.all params[:learning_path_id]
    render json: @quizzes, status: :ok
  end
  
  def show
    @quiz = Canvas::Quiz.find params[:learning_path_id], params[:id]
    render json: @quiz, status: :ok
  end
end