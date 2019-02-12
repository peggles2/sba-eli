require "rails_helper"

describe "Canvas::LearningPath" do
  include Mocks::LearningPathHelper

  describe "#all" do
    it "gets a list of all the courses" do
      stub_fetch_all_learning_paths
      expect(Canvas::LearningPath.all.length).to eq(2)
    end
  end

  describe "#find" do
    it "finds a course" do
    end
  end

  describe "#enroll" do
    let (:user_id) { 3 }
    let (:learning_path_id) { 6 }
    it "should enroll a user in to a course" do
      Current.user = User.new(id: user_id)
      stub_enroll_in_learning_path(user_id: user_id, learning_path_id: learning_path_id)
      response = Canvas::LearningPath.enroll(learning_path_id, Current.user)
      expect(response["user_id"]).to eq(user_id)
      expect(response["course_id"]).to eq(learning_path_id)
    end
  end
end
