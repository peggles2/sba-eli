require "rails_helper"

describe "EnrollsController" do
  include Mocks::LearningPathHelper
  include Mocks::UsersHelper
  include SessionHelper

  describe "learning_paths/:learning_path_id/enroll" do
    let (:learning_path_id) { 6 }
    let (:user_id) { 3 }
    let (:email) { "test.student@example.com" }

    it "returns a 401 if there is not an authenticated user" do
      VCR.turned_off do
        post "/learning_paths/#{learning_path_id}/enroll"
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(json["error"]).to eq("Not Authorized")
      end
    end

    it "returns OK if a user is authenticated" do
      VCR.turned_off do
        stub_get_user_request(id: user_id, email: email)
        stub_enroll_in_learning_path(user_id: user_id, learning_path_id: learning_path_id)
        post "/learning_paths/#{learning_path_id}/enroll",
          params: {},
          headers: authenticated_header(email: email, id: user_id)
        json = JSON.parse(response.body)
        expect(response).to be_successful
        expect(json["user_id"]).to eq(user_id)
        expect(json["course_id"]).to eq(learning_path_id)
      end
    end
  end
end
