# == Schema Information
#
# Table name: fearless_assessments
#
#  id          :bigint(8)        not null, primary key
#  course_id   :integer          not null
#  quiz_id     :integer          not null
#  name        :string
#  description :text
#  minimum     :decimal(, )
#  maximum     :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Assessment < FearlessRecord
  validates :course_id, :quiz_id, :name, presence: true
  validates :minimum, :maximum, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :minimum_is_less_than_maximum

  def minimum_is_less_than_maximum
    if minimum.present? && maximum.present? && minimum >= maximum
      errors.add(:minimum, "minimum must be less than maximum")
    end
  end
end
