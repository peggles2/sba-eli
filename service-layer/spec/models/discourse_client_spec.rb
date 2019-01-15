require "rails_helper"

describe "DiscourseClient" do
  include Mocks::DiscourseHelper

  let (:user_id) { 3 }
  let (:email) { "jane.doe@example.com" }
  let (:full_name) { "Jane Doe" }

  it "returns an instance of the Discourse API client" do
    expect(DiscourseClient.create.class).to eq(DiscourseApi::Client)
  end

  it "returns the result of creating a discourse user" do
    VCR.turned_off do
      stub_discourse_create_user(id: 3)
      response = JSON.parse DiscourseClient.create_user(user_id, email, full_name)

      expect(response["user_id"]).to eq(user_id)
      expect(response["active"]).to eq(true)
      expect(response["success"]).to eq(true)
    end
  end

  describe "#username_from_id" do
    it "returns a generated sting that is 20 characters" do
      expect(DiscourseClient.username_from_id(user_id).length).to eq(20)
    end
  end
end
