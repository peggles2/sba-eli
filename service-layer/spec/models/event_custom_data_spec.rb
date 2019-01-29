require "rails_helper"

RSpec.describe EventCustomData, type: :model do
  describe "#event_id" do
    it { should validate_presence_of :event_id }
  end
end
