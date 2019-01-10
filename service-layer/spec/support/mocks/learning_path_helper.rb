module Mocks
  module LearningPathHelper
    include JSONFixtures
    include RequestHelper
    def stub_fetch_all_learning_paths(options = {})
      status = options.fetch(:status, 200)
      url = "#{ENV['CANVAS_HOST']}/api/v1/courses"
      response_body = options.fetch(:response_body,
                                  json_string("learning_paths/learning_paths.json"))

      stub_authorized_request(:get, url).to_return(status: status, body: response_body)
    end

    def stub_enroll_in_learning_path(options = {})
      status = options.fetch(:status, 200)
      learning_path_id = options.fetch(:learning_path_id, 6)
      user_id = options.fetch(:user_id, 3)

      body = "enrollment[user_id]=#{user_id}"\
        "&enrollment[type]=StudentEnrollment"\
        "&enrollment[enrollment_state]=active"\
        "&enrollment[notify]=false"

      response_body = options.fetch(:response_body,
                                  json_hash("learning_paths/enrollment.json"))

      response_body["course_id"] = learning_path_id
      response_body["user_id"] = user_id

      url = "#{ENV['CANVAS_HOST']}/api/v1/courses/#{learning_path_id}/enrollments"
      stub_authorized_request_with_body(:post, url, body).to_return(
        status: status,
        body: response_body.to_json,
      )
    end
  end
end
