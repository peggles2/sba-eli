module Mocks
  module UsersHelper
    include JSONFixtures
    include RequestHelper

    def stub_create_user(options = {})
      url = "#{ENV['CANVAS_HOST']}/api/v1/accounts/1/users/"
      status = options.fetch(:status, 200)
      response_body = options.fetch(:response_body, json_string("users/create_user.json"))

      stub_request(:post, url).to_return(status: status, body: response_body)
    end

    def stub_delete_custom_data_request(options = {})
      id = options.fetch(:id, 1)
      status = options.fetch(:status, 200)
      url = "#{ENV['CANVAS_HOST']}/api/v1/users/#{id}/custom_data/?ns=#{ENV['CANVAS_NAMESPACE']}"
      response_body = options.fetch(:response_body,
                                  json_string("users/delete_custom_data.json"))

      stub_authorized_request(:delete, url).to_return(status: status, body: response_body)
    end

    def stub_delete_user_request(options = {})
      id = options.fetch(:id, 1)
      status = options.fetch(:status, 200)
      url = "#{ENV['CANVAS_HOST']}/api/v1/accounts/#{ENV['CANVAS_ACCOUNT_ID']}/users/#{id}"
      response_body = options.fetch(:response_body,
                                  json_string("users/delete_user.json"))
      stub_request(:delete, url).to_return(status: status, body: response_body)
    end

    def stub_fetch_by_email(options = {})
      id = options.fetch(:id, 10)
      email = options.fetch(:email, "jane.doe@example.com")
      first_name = options.fetch(:first_name, "Jane")
      last_name = options.fetch(:last_name, "Doe")
      # rubocop:disable Metrics/LineLength
      url = "#{ENV['CANVAS_HOST']}/api/v1/accounts/#{ENV['CANVAS_ACCOUNT_ID']}/users/?search_term=#{email}"
      # rubocop:enable Metrics/LineLength
      response = [
        {
          "id": id,
          "name": "#{first_name} #{last_name}",
          "created_at": "2018-11-16T05:35:20-07:00",
          "sortable_name": "#{last_name}, #{first_name}",
          "short_name": first_name,
          "sis_user_id": nil,
          "integration_id": nil,
          "sis_import_id": nil,
          "login_id": email,
        },
      ]

      response_body = options.fetch(:response_body, response.to_json)
      stub_request(:get, url).to_return(status: status, body: response_body)
    end

    def stub_get_custom_data_request(options = {})
      id = options.fetch(:id, 1)
      status = options.fetch(:status, 200)
      url = "#{ENV['CANVAS_HOST']}/api/v1/users/#{id}/custom_data/?ns=#{ENV['CANVAS_NAMESPACE']}"
      response_body = options.fetch(:response_body,
                                  json_string("users/custom_data_1.json"))

      stub_request(:get, url).to_return(status: status, body: response_body)
    end

    def stub_get_user_request(options = {})
      id = options.fetch(:id, 1)
      status = options.fetch(:status, 200)
      email = options.fetch(:email, "canvas@fearless.tech")
      response = {
        "id": id,
        "name": email,
        "created_at": "2018-10-22T08:51:52-06:00",
        "sortable_name": email,
        "short_name": email,
        "sis_user_id": nil,
        "integration_id": nil,
        "sis_import_id": nil,
        "login_id": email,
        "email": email,
        "locale": nil,
        "permissions": {
          "can_update_name": true,
          "can_update_avatar": false,
        },
      }
      url = "#{ENV['CANVAS_HOST']}/api/v1/users/#{id}"
      response_body = options.fetch(:response_body, response.to_json)

      stub_request(:get, url).to_return(status: status, body: response_body)
    end

    def stub_update_custom_data_request(options = {})
      id = options.fetch(:id, 1)
      status = options.fetch(:status, 200)
      url = "#{ENV['CANVAS_HOST']}/api/v1/users/#{id}/custom_data/"
      response_body = options.fetch(:response_body,
                                  json_string("users/update_custom_data.json"))

      stub_authorized_request(:put, url).to_return(status: status, body: response_body)
    end

    def stub_update_user_request(options = {})
      id = options.fetch(:id, 1)
      status = options.fetch(:status, 200)
      url = "#{ENV['CANVAS_HOST']}/api/v1/users/#{id}"
      response_body = options.fetch(:response_body,
                                  json_string("users/update_user.json"))

      stub_authorized_request(:put, url).to_return(status: status, body: response_body)
    end
  end
end
