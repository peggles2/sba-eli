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

  validates :first_name, :last_name, :email, presence: { message: "This is a required field" }
  validates :email, email: { message: "This is not a valid email format" }
  validates :password, password_complexity: true
  validates_confirmation_of :password

  def create
    return self if !valid?

    begin
      CognitoService.sign_up(email, password)
    rescue Aws::CognitoIdentityProvider::Errors::UsernameExistsException
      errors.add(:email, "already exists.")
      return self
    end

    response = Canvas::User.create_user(build_canvas_json)
    self.user = User.from_canvas_json(response)

    begin
      DiscourseClient.create_user(user.id, email, full_name)
    rescue DiscourseApi::UnprocessableEntity
      Rails.logger.error "Unable to create Discourse user for #{user.id}"
    end

    self
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
