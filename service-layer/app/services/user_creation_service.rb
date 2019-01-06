class UserCreationService
  include ActiveModel::Model

  attr_accessor :first_name,
                :middle_name,
                :last_name,
                :email,
                :short_name,
                :password,
                :zip_code,
                :in_business,
                :user

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, email: true
  validates :password, password_complexity: true
  validates_confirmation_of :password

  def create
    if !valid?
      Rails.logger.debug("errors on user: #{errors.inspect}")
      return false
    end
    Rails.logger.debug("creating user in cognito")

    begin
      CognitoService.sign_up(email, password)
    rescue Aws::CognitoIdentityProvider::Errors::UsernameExistsException
      Rails.logger.debug("tried to create an existing cognito user")
      errors.add(:email, "already exists.")
      return false
    end

    # TODO: We're going to want to save the user_sub from the
    # cognito response as a custom attribute in canvas

    Rails.logger.debug("trying to create user in canvas")
    # Create user in Canvas
    response = Canvas::User.create_user(build_canvas_json)
    self.user = User.from_canvas_json(response)

    true
  end

  private

  def build_canvas_json
    {
      "user": {
        "name": full_name,
        "sortable_name": sortable_name,
        "short_name": short_name,
        "email": email,
      },
      "pseudonym": {
        "unique_id": email,
      },
    }
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def sortable_name
    "#{last_name}, #{first_name}"
  end
end
