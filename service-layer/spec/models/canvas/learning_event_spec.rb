require "rails_helper"

describe "Canvas::LearningEvent" do
  include Mocks::LearningEventHelper

  describe "#done" do
    it "should return okay given a valid request" do
      Current.user = User.new(id: 3)

      params = {
        learning_path_id: 10,
        learning_objective_id: 73,
        learning_event_id: 3,
        user_id: Current.user.id,
      }

      stub_learning_event_done(params)
      VCR.turned_off do
        response = Canvas::LearningEvent.done(
          params[:learning_path_id],
          params[:learning_objective_id],
          params[:learning_event_id],
        )
        expect(response["message"]).to eq("OK")
      end
    end
  end
end
