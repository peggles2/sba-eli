module SessionHelper
  def sign_in_as_user(options = {})
    email = options.fetch(:email, "nick.watson@claritybizsol.com")
    password = options.fetch(:password, "changeME123!")
    VCR.use_cassette("sessions/create_valid_session") do
      params = { email: email, password: password }
      post "/session", params: params
    end
  end
end
