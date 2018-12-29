module Canvas
  module Quiz
    include Canvas::Base
    include HTTParty

    base_uri ENV["CANVAS_HOST"] + "/api/v1"
    
    def self.all(learning_path_id)
      quizzes = JSON.parse get("/courses/#{learning_path_id}/quizzes", base_options).body

      results = []

      quizzes.each do |quiz|
        results << {
          id:             quiz["id"],
          title:          quiz["title"],
          description:    quiz["description"]
        }
      end

      results
    end
    
    def self.find(learning_path_id, quiz_id)
      questions = JSON.parse get("/courses/#{learning_path_id}/quizzes/#{quiz_id}/questions", base_options).body

      results = []

      questions.each do |question|
        pp question

        answers = []

        question["answers"].each do |answer|
          a = {
            id: answer["id"],
            text: answer["text"]
          }

          a[:blank_id] = answer["blank_id"] if answer["blank_id"]
          a[:left] = answer["left"] if answer["left"]
          a[:right] = answer["right"] if answer["right"]
          a[:exact] = answer["exact"] if answer["exact"]

          answers << a
        end

        results << {
          id:               question["id"],
          quiz_id:          question["quiz_id"],
          question_type:    question["question_type"],
          question_text:    question["question_text"],
          answers:          answers
        }
      end

      results
    end
  end
end