class ResetPasswordsController < ApplicationController
  def create
    reset_password = ResetPassword.new(model_params)

    if reset_password.change
      render json: { "success": true }, status: :created
    else
      render_error(request_password, :unprocessable_entity)
    end
  end

  private

  def model_params
    params.require(:reset_password).permit(
      :email,
      :confirmation_code,
      :password,
      :password_confirmation,
    )
  end
end
