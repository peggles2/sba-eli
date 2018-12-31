class QuizzesController < ApplicationController
  def index
    @quizzes = Canvas::Quiz.all params[:learning_path_id]
    render json: @quizzes, status: :ok
  end
  
  def show
    submission = Canvas::Quiz.start_submission params[:learning_path_id], params[:id]

    @quiz = Canvas::Quiz.find params[:learning_path_id], params[:id], submission

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
  #     answer: 1234  - for multiple choice, this should be the answer ID
  #   }, {
  #     id: 2,
  #     answer: 5678  - for multiple choice, this should be the answer ID
  #   }]
  # }
  def update
    quiz_answer_resp = Canvas::Quiz.submit params
    end_submission_resp = Canvas::Quiz.end_submission params[:learning_path_id], params[:id], params

    render json: end_submission_resp, status: :ok
  end
end