require "rails_helper"

describe "DiscussionReply" do
  include Mocks::DiscourseHelper
  include Mocks::UsersHelper

  subject do
    DiscussionReply.new(
      discussion_id: 7,
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

  it "is invalid without a discussion_id" do
    subject.discussion_id = nil
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

  it "creates a new post" do
    VCR.turned_off do
      stub_discourse_create_post
      expect(subject.create).to be_truthy
    end
  end
end
