require "rails_helper"

RSpec.describe CustomContent, type: :model do
  describe "#contentable_type" do
    it { should validate_presence_of :contentable_type }
  end

  describe "#contentable_id" do
    it { should validate_presence_of :contentable_id }
  end

  describe "#content" do
    it { should validate_presence_of :content }
  end
end
