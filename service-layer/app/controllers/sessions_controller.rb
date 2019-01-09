class SessionsController < ApplicationController
  include SecurityConcern

  skip_before_action :authenticate_request, only: :create
  before_action :valid_session?, only: :destroy

  def create
    @cognito_response = CognitoService.authenticate(params[:email], params[:password])
    Rails.logger.info @cognito_response
    canvas_user_response = Canvas::User.fetch_by_email(params[:email])
    sign_in User.from_canvas_json(canvas_user_response)
  rescue Aws::CognitoIdentityProvider::Errors::NotAuthorizedException,
         Aws::CognitoIdentityProvider::Errors::UserNotFoundException

    render json: {}, status: :forbidden
  end

  def destroy
    sign_out
    head :ok
  end
end
