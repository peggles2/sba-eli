# == Schema Information
#
# Table name: fearless_discussion_maps
#
#  id            :bigint(8)        not null, primary key
#  discussion_id :integer          not null
#  content_type  :string           not null
#  content_id    :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_fearless_discussion_maps_on_discussion_id  (discussion_id) UNIQUE
#

class DiscussionMap < FearlessRecord
  validates :discussion_id, presence: true, uniqueness: true
  validates_presence_of :content_type, :content_id
end
