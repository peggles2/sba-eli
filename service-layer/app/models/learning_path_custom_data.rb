# == Schema Information
#
# Table name: fearless_learning_path_custom_data
#
#  id               :bigint(8)        not null, primary key
#  learning_path_id :integer          not null
#  time             :string
#  description      :string
#  thumbnail_url    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_fearless_learning_path_custom_data_on_learning_path_id  (learning_path_id) UNIQUE
#

class LearningPathCustomData < FearlessRecord
  validates :learning_path_id, presence: true
end
