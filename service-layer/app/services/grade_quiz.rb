class GradeQuiz
  include ActiveModel::Model

  attr_accessor :learning_path_id, :quiz_id, :quiz_questions

  validates :quiz_id, :learning_path_id, :quiz_questions, presence: true

  def grade
    return self unless valid?

    assessment = Assessment.where(quiz_id: quiz_id)

    Canvas::Quiz.grade(
      learning_path_id,
      quiz_id,
      assessment.to_a,
      quiz_questions,
    )
  rescue StandardError
    self
  end
end
