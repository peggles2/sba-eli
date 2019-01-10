class ChangePassword
  include ActiveModel::Model

  attr_accessor :previous_password, :password, :password_confirmation

  validates :previous_password, presence: true
  validates :password, password_complexity: true
  validates_confirmation_of :password

  def change
    return false unless valid?

    CognitoService.change_password(previous_password, password, Current.access_token)

    true
  rescue StandardError
    false
  end
end
