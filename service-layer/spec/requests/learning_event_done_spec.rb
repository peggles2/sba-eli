require "rails_helper"

describe "LearningEventDone" do
  include Mocks::LearningEventHelper
  include Mocks::UsersHelper
  include SessionHelper

  describe "learning_paths/:learning_path_id/learning_objectives/"\
      ":learning_objective_id/learning_events/:id/done" do
    let (:learning_path_id) { 10 }
    let (:learning_objective_id) { 73 }
    let (:learning_event_id) { 3 }
    let (:user_id) { 3 }
    let (:email) { "test.student@example.com" }

    it "returns a 401 if there is not an authenticated user" do
      VCR.turned_off do
        put "/learning_paths/#{learning_path_id}/learning_objectives/"\
            "#{learning_objective_id}/learning_events/#{learning_event_id}/done"
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(json["error"]).to eq("Not Authorized")
      end
    end

    it "returns OK if a user is authenticated" do
      sign_in_as_user
      VCR.turned_off do
        stub_get_user_request(id: user_id)
        stub_learning_event_done(user_id: user_id)
        put "/learning_paths/#{learning_path_id}/learning_objectives/"\
            "#{learning_objective_id}/learning_events/#{learning_event_id}/done",
            params: {},
            headers: authenticated_header(email: email, id: user_id)
        json = JSON.parse(response.body)
        expect(response).to be_successful
        expect(json["message"]).to eq("OK")
      end
    end
  end
end
