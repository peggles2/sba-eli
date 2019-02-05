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

FactoryBot.define do
  factory :assessment do
    course_id { 1 }
    quiz_id { 1 }
    description { "MyText" }
    minimum { "9.99" }
    maximum { "9.99" }
  end
end
