module SessionHelper
  include Mocks::CognitoHelper
  include Mocks::UsersHelper

  def sign_in_as_user(options = {})
    email = options.fetch(:email, "jane.doe@example.com")
    password = options.fetch(:password, "changeME123!")
    Aws.config[:cognitoidentityprovider] = {
      stub_responses: {
        initiate_auth: sign_in_response,
        get_user: get_user_response(options),
      },
    }
    stub_fetch_by_email(options)
    params = { email: email, password: password }
    post "/session", params: params
    JSON.parse(response.body)["access_token"]
  end

  def authenticated_header(options = {})
    { "AUTHORIZATION": sign_in_as_user(options) }
  end
end
