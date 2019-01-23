class SignUpsController < ApplicationController
  def create
    params.delete(:sign_up)
    params.delete(:format)
    new_account = UserCreationService.new(model_params).create

    status = :unprocessable_entity
    status = :created unless new_account.errors.any?

    render json: new_account, status: status
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
