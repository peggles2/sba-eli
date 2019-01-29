class AssessmentController < ApplicationController
  def create
    @assessment = Assessment.create(assessment_params)

    if @assessment.save
      render json: @assessment, status: :created
    else
      render json: errors_for(@assessment), status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: e.message, status: :bad_request
  end

  def index
    render json: Assessment.where(quiz_id: params[:quiz_id])
  rescue StandardError => e
    render json: e.message, status: :bad_request
  end

  def update
    s = Assessment.where(id: params[:id])
    s.update assessment_params
    render json: Assessment.where(quiz_id: params[:quiz_id])
  rescue StandardError => e
    render json: e.message, status: :bad_request
  end

  def destroy
    Assessment.destroy(params[:id])
    render json: Assessment.where(quiz_id: params[:quiz_id])
  rescue StandardError => e
    render json: e.message, status: :bad_request
  end

  private

  def assessment_params
    params.require(:assessment).permit(
      :name,
      :description,
      :minimum,
      :maximum,
    ).merge(
      course_id: params[:learning_path_id],
      quiz_id: params[:quiz_id],
    )
  end
end
