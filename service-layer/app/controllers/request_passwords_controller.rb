class RequestPasswordsController < ApplicationController
  def create
    request_password = RequestPassword.new(model_params)

    if request_password.create
      render json: { "success": true }, status: :created
    else
      render_error(request_password, :unprocessable_entity)
    end
  end

  private

  def model_params
    params.require(:request_password).permit(:email)
  end
end
