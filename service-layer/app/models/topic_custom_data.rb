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

class TopicCustomData < FearlessRecord
  validates :topic_id, presence: true
end
