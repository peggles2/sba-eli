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

class CustomContent < FearlessRecord
  belongs_to :contentable, polymorphic: true

  validates_presence_of :contentable_type, :contentable_id, :content
end
