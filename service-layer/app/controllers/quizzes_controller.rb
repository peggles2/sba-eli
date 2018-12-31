class QuizzesController < ApplicationController
  def index
    @quizzes = Canvas::Quiz.all params[:learning_path_id]
    render json: @quizzes, status: :ok
  end
  
  def show
    @quiz = Canvas::Quiz.find params[:learning_path_id], params[:id]
    @submission = Canvas::Quiz.start_submission params[:learning_path_id], params[:id]

    @quiz[:submission] = @submission
    render json: @quiz, status: :ok
  end

  ##
  # a submission looks like this:
  # {
  #   submission_id: 1,
  #   attempt: 1,
  #   validation_token: 'token',
  #   quiz_questions: [{
  #     id: 1,
  #     answer: "Hello World!"
  #   }, {
  #     id: 2,
  #     answer: 42.0
  #   }]
  # }
  def create
    Canvas::Quiz.submission params
    @resp = Canvas::Quiz.end_submission params[:learning_path_id], params[:id], params

    render json: @resp, status: :ok
  end
end