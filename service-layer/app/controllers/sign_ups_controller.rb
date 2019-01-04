class SignUpsController < ApplicationController
  def create
    params.delete(:sign_up)
    params.delete(:format)
    new_account = UserCreationService.new(model_params)

    if new_account.create
      render json: new_account.user, status: :created
    else
      render_error(new_account.to_json, :unprocessable_entity)
    end
  end

  private

  def model_params
    params.permit(
      :first_name,
      :middle_name,
      :last_name,
      :email,
      :password,
      :zip_code,
      :in_business,
    )
  end
end
