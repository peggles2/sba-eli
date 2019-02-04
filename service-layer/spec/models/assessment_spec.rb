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

require "rails_helper"

RSpec.describe Assessment, type: :model do
  subject(:instance) { described_class.new(params) }

  context do
    let(:params) { { course_id: 1, quiz_id: 1, name: "name", minimum: 10, maximum: 20 } }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    describe "#course_id" do
      it { should validate_presence_of :course_id }
    end

    describe "#quiz_id" do
      it { should validate_presence_of :quiz_id }
    end

    describe "#name" do
      it { should validate_presence_of :name }
    end

    describe "#minimum" do
      it { should validate_presence_of :minimum }
      it { should validate_numericality_of :minimum }
      it "is invalid when minimum larger than maximum" do
        subject.minimum = 100
        expect(subject).to_not be_valid
      end
    end

    describe "#maximum" do
      it { should validate_presence_of :maximum }
      it { should validate_numericality_of :maximum }
    end
  end
end
