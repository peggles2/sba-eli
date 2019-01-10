class ResetPassword
  include ActiveModel::Model

  attr_accessor :email, :confirmation_code, :password, :password_confirmation

  validates :confirmation_code, presence: true
  validates :email, presence: true, email: true
  validates :password, password_complexity: true
  validates_confirmation_of :password

  def change
    return false unless valid?

    begin
      CognitoService.change_password(email, confirmation_code, password)
    rescue StandardError
      false
    end
    true
  end
end
