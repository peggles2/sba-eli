require "rails_helper"

describe "DiscussionRepliesController" do
  include Mocks::DiscourseHelper
  include Mocks::UsersHelper
  include SessionHelper

  describe "discussions/:discussion_id/discussion_replies" do
    let (:discussion_id) { 7 }
    let (:user_id) { 3 }
    let (:raw) { "This is the content of the post. Needs to be over 20 characters" }
    let (:email) { "jane.doe@example.com" }

    it "returns a 401 if there is not an authenticated user" do
      VCR.turned_off do
        post "/discussions/#{discussion_id}/discussion_replies"
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(json["error"]).to eq("Not Authorized")
      end
    end

    it "returns OK if a user is authenticated" do
      VCR.turned_off do
        stub_get_user_request(id: user_id, email: email)
        stub_discourse_create_post(user_id: user_id)
        post "/discussions/#{discussion_id}/discussion_replies",
          params: {
            discussion_reply: {
              raw: raw,
            },
          },
          headers: authenticated_header(email: email, id: user_id)
        json = JSON.parse(response.body)
        expect(response).to be_successful
        expect(json["user_id"]).to eq(user_id)
      end
    end
  end
end
