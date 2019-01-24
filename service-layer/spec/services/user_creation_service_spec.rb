require "rails_helper"

describe "UserCreationService" do
  include Mocks::CognitoHelper
  include Mocks::DiscourseHelper
  include Mocks::UsersHelper

  subject do
    UserCreationService.new(
      first_name: "Jane",
      last_name: "Doe",
      email: "jane.doe@example.com",
      password: "changeME123!",
      password_confirmation: "changeME123!",
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without first_name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without last_name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without a complex password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is invalid if password doesn't match password_confirmation" do
    subject.password_confirmation = "123ChangeME"
    expect(subject).to_not be_valid
  end

  context do
    before :context do
      Aws.config[:cognitoidentityprovider] = {
        stub_responses: {
          sign_up: sign_up_existing_user,
        },
      }
    end

    it "fails to create a user if the email is already registered" do
      subject.email = "john.doe@doe.com"
      VCR.use_cassette("failed_user_creation") do
        expect(subject.create.errors.any?).to be_truthy
      end
    end
  end

  context do
    before :context do
      Aws.config[:cognitoidentityprovider] = {
        stub_responses: {
          sign_up: sign_up_user("jane.doe@example.com"),
        },
      }
    end
    it "creates a new user" do
      stub_create_user
      stub_discourse_create_user
      expect(subject.create).to be_truthy
    end
  end
end
