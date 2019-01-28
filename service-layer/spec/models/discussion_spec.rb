require "rails_helper"

describe "Discussion" do
  include Mocks::DiscourseHelper
  include Mocks::UsersHelper

  subject do
    Discussion.new(
      content_type: "learning_path",
      content_id: 4,
      raw: "This is the content of the post. Needs to be over 20 characters",
      user: User.new(
        id: 3,
        name: "Jane Doe",
        sortable_name: "Doe, Jane",
        short_name: "jane",
        login_id: "jane.doe@example.com",
      ),
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without a content_type" do
    subject.content_type = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without a content_id" do
    subject.content_id = nil
    expect(subject).to_not be_valid
  end

  it "is invalid without a raw value" do
    subject.raw = nil
    expect(subject).to_not be_valid
  end

  it "is invalid if the raw value is under 20 characters" do
    subject.raw = "Under 20"
    expect(subject).to_not be_valid
  end

  it "is invalid without user" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it "creates a new discussion" do
    VCR.turned_off do
      stub_discourse_create_post(user_id: subject.user.id)
      expect(subject.create).to be_truthy
    end
  end
end
