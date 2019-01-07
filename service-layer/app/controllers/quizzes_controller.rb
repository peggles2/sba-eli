class QuizzesController < ApplicationController
  def index
    begin
      @quizzes = Canvas::Quiz.all params[:learning_path_id]
      render json: @quizzes, status: :ok
    rescue Exception => e
      render json: e.message, status: :bad_request
    end
  end
  
  def show
    begin
      submission = Canvas::Quiz.start_submission params[:learning_path_id], params[:id]

      @quiz = Canvas::Quiz.find params[:learning_path_id], params[:id], submission

      render json: @quiz, status: :ok
    rescue Exception => e
      render json: e.message, status: :bad_request
    end
  end

  def submissions
    begin
      @submissions = Canvas::Quiz.get_submissions params[:learning_path_id], params[:id]

      render json: @submissions, status: :ok
    rescue Exception => e
      render json: e.message, status: :bad_request
    end
  end

  ##
  # a submission looks like this:
  # {
  #   quiz_id: 1
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
  def create
    begin
      quiz_answer_resp = Canvas::Quiz.submit params
      pp quiz_answer_resp
      end_submission_resp = Canvas::Quiz.end_submission params[:learning_path_id], params
      pp end_submission_resp
      render json: end_submission_resp, status: :ok
    rescue Exception => e
      render json: e.message, status: :bad_request
    end
  end
end