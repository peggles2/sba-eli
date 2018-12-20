# == Schema Information
#
# Table name: fearless_custom_contents
#
#  id               :bigint(8)        not null, primary key
#  contentable_type :string           not null
#  contentable_id   :integer          not null
#  content          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  idx_custom_contents_contentable_type_contentable_id  (contentable_type,contentable_id) UNIQUE
#

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
