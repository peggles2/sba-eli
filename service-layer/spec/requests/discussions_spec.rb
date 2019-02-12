require "rails_helper"

describe "DiscussionsController" do
  include Mocks::DiscourseHelper
  include Mocks::UsersHelper
  include SessionHelper

  describe "POST discussions/:content_type/content_id" do
    let (:content_type) { "learning_path" }
    let (:content_id) { 4 }
    let (:user_id) { 3 }
    let (:raw) { "This is the content of the post. Needs to be over 20 characters" }
    let (:email) { "jane.doe@example.com" }

    it "returns a 401 if there is not an authenticated user" do
      VCR.turned_off do
        post "/discussions/#{content_type}/#{content_id}"
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(json["error"]).to eq("Not Authorized")
      end
    end

    it "Creates new discussion a new post" do
      VCR.turned_off do
        stub_get_user_request(id: user_id, email: email)
        stub_discourse_create_post(user_id: user_id)
        post "/discussions/#{content_type}/#{content_id}",
          params: {
            discussion_reply: {
              raw: raw,
            },
          },
          headers: authenticated_header(email: email, id: user_id)
        json = JSON.parse(response.body)

        expect(response).to be_successful
      end
    end
  end
end
