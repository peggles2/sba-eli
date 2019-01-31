require "rails_helper"

RSpec.describe TopicCustomData, type: :model do
  describe "#topic_id" do
    it { should validate_presence_of :topic_id }
  end
end
