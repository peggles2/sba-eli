module Mocks
  module DiscourseHelper
    include RequestHelper

    def stub_discourse_create_user(options = {})
      id = options.fetch(:id, 10)
      status = options.fetch(:status, 200)

      response = {
        "success": true,
        "active": true,
        "message": "Your account is activated and ready to use.",
        "user_id": id,
      }

      url = "#{ENV['DISCOURSE_HOST']}/users?api_key=#{ENV['DISCOURSE_API_KEY']}"\
            "&api_username=#{ENV['DISCOURSE_USER']}"

      response_body = options.fetch(:response_body, response.to_json)
      stub_request(:post, url).to_return(status: status, body: response_body)
    end
  end
end
