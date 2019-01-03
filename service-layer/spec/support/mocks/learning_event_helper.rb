module Mocks
  module LearningEventHelper
    include JSONFixtures
    include RequestHelper

    def stub_learning_event_done(options = {})
      learning_path_id = options.fetch(:learning_path_id, 10)
      learning_objective_id = options.fetch(:learning_objective_id, 73)
      learning_event_id = options.fetch(:learning_event_id, 3)
      user_id = options.fetch(:user_id, 3)
      status = options.fetch(:status, 200)

      url = "#{ENV['CANVAS_HOST']}/api/v1/courses/#{learning_path_id}/modules/"\
            "#{learning_objective_id}/items/#{learning_event_id}/done?as_user_id=#{user_id}"

      response_body = options.fetch(:response_body,
                                  json_string("learning_events/learning_event_done.json"))

      stub_authorized_request(:put, url).to_return(status: status, body: response_body)
    end
  end
end
