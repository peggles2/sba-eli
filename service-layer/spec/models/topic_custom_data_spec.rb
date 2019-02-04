# == Schema Information
#
# Table name: fearless_topic_custom_data
#
#  id            :bigint(8)        not null, primary key
#  topic_id      :integer          not null
#  time          :string
#  description   :string
#  thumbnail_url :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_fearless_topic_custom_data_on_topic_id  (topic_id) UNIQUE
#

require "rails_helper"

RSpec.describe TopicCustomData, type: :model do
  describe "#topic_id" do
    it { should validate_presence_of :topic_id }
  end
end
