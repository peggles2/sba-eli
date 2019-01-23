require "rails_helper"

describe "RequestPassword" do
  include Mocks::CognitoHelper

  subject do
    RequestPassword.new(
      email: "jane.doe@example.com",
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without an email address" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  context do
    before :context do
      Aws.config[:cognitoidentityprovider] = {
        stub_responses: {
          forgot_password: forgot_password_response("jane.doe@example.com"),
        },
      }
    end

    it "requests a password reset" do
      expect(subject.create).to be_truthy
    end
  end
end
