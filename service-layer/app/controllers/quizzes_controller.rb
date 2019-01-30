class QuizzesController < ApplicationController
  def index
    @quizzes = Canvas::Quiz.all params[:learning_path_id]
    render json: @quizzes, status: :ok
  rescue StandardError => e
    render json: e.message, status: :bad_request
  end

  def show
    # Commenting out to ignore submissionss for assessment purposes.
    #  We can get submission objects once we actually start grading quizes
    # submission = Canvas::Quiz.start_submission params[:learning_path_id], params[:id]
    submission = nil
    @quiz = Canvas::Quiz.find params[:learning_path_id], params[:id], submission
    render json: @quiz, status: :ok
  rescue StandardError => e
    render json: e.message, status: :bad_request
  end

  def submissions
    @submissions = Canvas::Quiz.get_submissions params[:learning_path_id], params[:id]

    render json: @submissions, status: :ok
  rescue StandardError => e
    render json: e.message, status: :bad_request
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
    assessment = Assessment.where(quiz_id: params[:quiz_id])
    quiz_answer_resp = Canvas::Quiz.grade(
      params[:learning_path_id],
      params[:quiz_id],
      assessment.to_a,
      params[:quiz][:quiz_questions],
    )

    render json: quiz_answer_resp, status: :created
  rescue StandardError => e
    render json: e.message, status: :bad_request
  end
end
