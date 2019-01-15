require "rails_helper"

describe "ResetPasswordsController" do
  include Mocks::CognitoHelper

  describe "POST /reset_password" do
    before :context do
      Aws.config[:cognitoidentityprovider] = {
        stub_responses: {
          confirm_forgot_password: confirm_forgot_password,
        },
      }
    end

    let (:uri) { "/reset_password" }

    it "creates a valid password reset request" do
      params = {
        "reset_password[email]": "jane.doe@example.com",
        "reset_password[confirmation_code]": "12345678",
        "reset_password[password]": "changeME123!",
        "reset_password[password_confirmation]": "changeME123!",
      }

      post uri, params: params
      expect(response).to be_successful
    end
  end
end
