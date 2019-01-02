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
    
    def self.find(learning_path_id, quiz_id, submission)
      quiz = JSON.parse get("/courses/#{learning_path_id}/quizzes/#{quiz_id}", base_options).body
      questions = JSON.parse get("/courses/#{learning_path_id}/quizzes/#{quiz_id}/questions", base_options).body

      result = {
        id:                 quiz["id"],
        title:              quiz["title"],
        description:        quiz["description"],
        submission_id:      submission["submission_id"],
        attempt:            submission["attempt"],
        validation_token:   submission["validation_token"],
        questions:          []
      }

      questions.each do |question|
        answers = []

        pp question
        question["answers"].each do |answer|
          a = {
            id: answer["id"],
            text: answer["text"]
          }

          answers << a
        end unless question["answers"].nil?

        result[:questions] << {
          id:               question["id"],
          question_name:    question["question_name"],
          question_type:    question["question_type"],
          question_text:    question["question_text"],
          answers:          answers
        }
      end

      result
    end

    def self.get_submissions(learning_path_id, quiz_id)
      submissions = JSON.parse get("/courses/#{learning_path_id}/quizzes/#{quiz_id}/submissions", base_options).body
      submissions["quiz_submissions"]
    end

    def self.start_submission(learning_path_id, quiz_id)      
      submissions = JSON.parse get("/courses/#{learning_path_id}/quizzes/#{quiz_id}/submissions", base_options).body
      submission = {}

      print submissions
      if(!submissions or submissions["quiz_submissions"].empty?)
        submissions = JSON.parse post("/courses/#{learning_path_id}/quizzes/#{quiz_id}/submissions", base_options).body
      end

      submissions["quiz_submissions"].first
    end

    def self.submit(submission)
      options = base_options.merge!(body: {
        attempt: submission["attempt"],
        validation_token: submission["validation_token"],
        quiz_questions: []
      })

      submission["quiz_questions"].each do |quiz_question|
        options[:body][:quiz_questions] << {id: quiz_question["id"], answer: quiz_question["answer"]}
      end

      JSON.parse post("/quiz_submissions/#{submission["submission_id"]}/questions", options).body
    end

    def self.end_submission(learning_path_id, quiz_id, submission)
      options = base_options.merge!(body: {
        attempt: submission["attempt"],
        validation_token: submission["validation_token"]
      })

      JSON.parse post("/courses/#{learning_path_id}/quizzes/#{quiz_id}/submissions/#{submission["submission_id"]}/complete", options).body
    end
  end
end