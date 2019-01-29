# == Schema Information
#
# Table name: fearless_assessments
#
#  id          :bigint(8)        not null, primary key
#  course_id   :integer
#  quiz_id     :integer
#  name        :string
#  description :text
#  minimum     :decimal(, )
#  maximum     :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Assessment < FearlessRecord
end
