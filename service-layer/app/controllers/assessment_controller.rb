class AssessmentController < ApplicationController
  
    def create
      @assessment = Assessment.create(
        description: params[:assessment][:description],
        name: params[:assessment][:name],
        course_id: params[:learning_path_id],
        quiz_id: params[:quiz_id],
        minimum: params[:assessment][:minimum],
        maximum: params[:assessment][:maximum]
        )
      if @assessment.save
        render json: @assessment, status: :created
      else
        render json: errors_for(@assessment), status: :unprocessable_entity
      end
    end
  
    def index
      begin
        render json: Assessment.where(quiz_id: params[:quiz_id])
      rescue Exception => e
        render json: e.message, status: :bad_request
      end
    end
  
    def update
      begin
        s = Assessment.where(id: params[:id])
        s.update assessment_params
        render json: Assessment.where(quiz_id: params[:quiz_id])
      rescue Exception => e
        render json: e.message, status: :bad_request
      end
    end

    def destroy
      begin
        Assessment.destroy(params[:id])
        render json: Assessment.where(quiz_id: params[:quiz_id])
      rescue Exception => e
        render json: e.message, status: :bad_request
      end
    end

    private
    def assessment_params
      params.require(:assessment).permit(:name, :description, :minimum, :maximum )
    end
  end