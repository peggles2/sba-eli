require "rails_helper"

describe "RequestPasswordsController" do
  include Mocks::CognitoHelper

  describe "POST /request_password" do
    before :context do
      Aws.config[:cognitoidentityprovider] = {
        stub_responses: {
          forgot_password: forgot_password_response("jane.doe@example.com"),
        },
      }
    end

    let (:uri) { "/request_password" }

    it "creates a valid password reset request" do
      params = {
        "request_password[email]": "jane.doe@example.com",
      }

      post uri, params: params
      expect(response).to be_successful
    end
  end
end
