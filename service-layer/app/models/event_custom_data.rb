# == Schema Information
#
# Table name: fearless_event_custom_data
#
#  id            :bigint(8)        not null, primary key
#  event_id      :integer          not null
#  time          :string
#  description   :string
#  thumbnail_url :string
#  event_type    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_fearless_event_custom_data_on_event_id  (event_id) UNIQUE
#

class EventCustomData < FearlessRecord
  validates :event_id, presence: true
end
