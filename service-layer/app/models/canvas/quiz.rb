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
      quiz = JSON.parse get("/courses/#{learning_path_id}/quizzes/#{quiz_id}", base_options).body

      result = {
        id:             quiz["id"],
        title:          quiz["title"],
        description:    quiz["description"],
        questions:      []
      }

      questions.each do |question|
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

        result[:questions] << {
          id:               question["id"],
          quiz_id:          question["quiz_id"],
          question_type:    question["question_type"],
          question_text:    question["question_text"],
          answers:          answers
        }
      end

      result
    end

    def self.start_submission(learning_path_id, quiz_id)
      post("/courses/#{learning_path_id}/quizzes/#{quiz_id}/submissions", base_options)
    end

    def self.submit(submission)
      options = base_options.merge!(body: submission)
      post("/quiz_submissions/#{submission["submission_id"]}/questions", options)
    end

    def self.end_submission(learning_path_id, quiz_id, submission)
      options = base_options.merge!(body: {
        attempt: submission["attempt"],
        validation_token: submission["validation_token"]
      })
      post("/courses/#{learning_path_id}/quizzes/#{quiz_id}/submissions/#{submission["submission_id"]}/completed", options)
    end
  end
end