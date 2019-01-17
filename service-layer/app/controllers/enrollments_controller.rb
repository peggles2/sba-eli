class EnrollmentsController < ApplicationController
  before_action :valid_session?

  def index
    response = Canvas::User.enrollments(params[:user_id])
    render json: response
  end
end
