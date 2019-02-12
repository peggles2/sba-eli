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

  it "sets attributes given a valid json response" do
    json_response = {
      "id": 2,
      "cooked": "body",
      "display_username": "username",
      "user_title": "user_title",
      "created_at": Time.now,
      "post_number": 2,
      "reply_to_post_number": 1,
    }

    object = DiscussionReply.from_hash(json_response)

    expect(object.id).to eql json_response["id"]
    expect(object.body).to eql json_response["cooked"]
    expect(object.user_name).to eql json_response["display_username"]
    expect(object.timestamp).to eql json_response["created_at"]
    expect(object.post_number).to eql json_response["post_number"]
    expect(object.reply_to_post_number).to eql json_response["reply_to_post_number"]
  end

  it "creates a new post" do
    VCR.turned_off do
      stub_discourse_create_post
      expect(subject.create).to be_truthy
    end
  end
end
