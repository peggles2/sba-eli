module SessionHelper
  include Mocks::CognitoHelper
  include Mocks::UsersHelper

  def sign_in_as_user(options = {})
    email = options.fetch(:email, "nick.watson@claritybizsol.com")
    password = options.fetch(:password, "changeME123!")
    Aws.config[:cognitoidentityprovider] = {
      stub_responses: {
        initiate_auth: sign_in_response,
      },
    }
    stub_fetch_by_email
    VCR.turned_off do
      params = { email: email, password: password }
      post "/session", params: params
    end
  end
end
