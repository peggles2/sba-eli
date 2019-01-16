class RequestPassword
  include ActiveModel::Model
  include Callable

  attr_accessor :email

  validates :email, presence: true, email: true

  def create
    return false unless valid?

    CognitoService.forgot_password(email)

    true
  end
end
