class EnrollmentsController < ApplicationController

  def index
    response = Canvas::User.enrollments(params[:user_id])
    render json: response
  end

  def latest
    response = Canvas::User.latest_enrollment(params[:user_id])
    render json: response
  end
end
