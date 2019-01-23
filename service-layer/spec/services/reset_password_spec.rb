require "rails_helper"

describe "ResetPassword" do
  include Mocks::CognitoHelper

  subject do
    ResetPassword.new(
      email: "jane.doe@example.com",
      confirmation_code: "1234567",
      password: "changeME123!",
      password_confirmation: "changeME123!",
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without email address" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without a confirmation code" do
    subject.confirmation_code = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is invalid if password and password_confirmation do not match" do
    subject.password_confirmation = "This1sN0tMyP@ssW0rd"
    expect(subject).to_not be_valid
  end

  it "is invalid without an password thats complex" do
    subject.password = "changeME123"
    expect(subject).to_not be_valid
  end

  context do
    before :context do
      Aws.config[:cognitoidentityprovider] = {
        stub_responses: {
          confirm_forgot_password: confirm_forgot_password,
        },
      }
    end

    it "resets password" do
      expect(subject.change).to be_truthy
    end
  end
end
