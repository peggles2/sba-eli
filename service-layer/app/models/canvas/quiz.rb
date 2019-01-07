module Canvas
  module Quiz
    include Canvas::Base
    include HTTParty

    base_uri ENV["CANVAS_HOST"] + "/api/v1"
    
    def self.all(learning_path_id)
      res = get("/courses/#{learning_path_id}/quizzes", base_options)
      quizzes = res.body

      raise Exception, quizzes unless res.code == 200

      quizzes = JSON.parse quizzes

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
      res = get("/courses/#{learning_path_id}/quizzes/#{quiz_id}", base_options)
      quiz = res.body

      raise Exception, quiz unless res.code == 200

      quiz = JSON.parse quiz

      res = get("/quiz_submissions/#{submission["submission_id"]}/questions", base_options)
      questions = res.body

      raise Exception, questions unless res.code == 200

      questions = JSON.parse questions

      questions = questions["quiz_submission_questions"]

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
      res = get("/courses/#{learning_path_id}/quizzes/#{quiz_id}/submissions", base_options)
      submissions = res.body

      raise Exception, submissions unless res.code == 200

      submissions = JSON.parse submissions

      submissions["quiz_submissions"]
    end

    def self.start_submission(learning_path_id, quiz_id)      
      res = get("/courses/#{learning_path_id}/quizzes/#{quiz_id}/submissions", base_options)
      submissions = res.body

      raise Exception, submissions unless res.code == 200

      submissions = JSON.parse submissions
      
      submission = {}

      if(!submissions.nil? and (submissions["quiz_submissions"].empty? or submissions["quiz_submissions"].length > 1 or !submissions["quiz_submissions"].first["finished_at"].nil?))
        res = post("/courses/#{learning_path_id}/quizzes/#{quiz_id}/submissions", base_options)
        submissions = res.body

        raise Exception, submissions unless res.code == 200

        submissions = JSON.parse submissions
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

      res = post("/quiz_submissions/#{submission["submission_id"]}/questions", options)
      body = res.body

      raise Exception, body unless res.code == 200

      JSON.parse body
    end

    def self.end_submission(learning_path_id, submission)
      options = base_options.merge!(body: {
        attempt: submission["attempt"],
        validation_token: submission["validation_token"]
      })
      quiz_id = submission[:quiz_id]

      res = post("/courses/#{learning_path_id}/quizzes/#{quiz_id}/submissions/#{submission["submission_id"]}/complete", options)
      body = res.body

      raise Exception, body unless res.code == 200

      JSON.parse body
    end
  end
end