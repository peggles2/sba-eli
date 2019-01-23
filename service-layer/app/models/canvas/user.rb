require "uri"

module Canvas
  module User
    include Canvas::Base
    include HTTParty

    base_uri "#{canvas_host}/api/v1/"

    def self.all
      response = get(canvas_accounts_url, base_options).body
      JSON.parse response
    end

    def self.fetch_by_email(email)
      JSON.parse(
        get(
          "#{canvas_accounts_url}?search_term=#{CGI.escape(email)}",
          base_options,
        ).body,
      ).first
    end

    def self.read_user(user_id)
      response = get(canvas_user_url(user_id), base_options).body
      JSON.parse response
    end

    def self.read_user_custom_data(user_id)
      response = get(
        "#{canvas_custom_data_url(user_id)}?ns=#{ENV['CANVAS_NAMESPACE']}",
        base_options,
      ).body
      JSON.parse response
    end

    def self.create_user(user_body)
      options = base_options.merge!(body: user_body)
      response = post(canvas_accounts_url, options).body
      JSON.parse response
    end

    def self.update_user(user_id, user_body)
      options = base_options.merge!(body: user_body)
      response = put(canvas_user_url(user_id), options).body
      JSON.parse response
    end

    # both update and create
    def self.user_custom_data(user_id, custom_data_body)
      options = base_options.merge!(body: custom_data_body)
      response = put(canvas_custom_data_url(user_id), options).body
      JSON.parse response
    end

    def self.destroy(user_id)
      response = delete("#{canvas_accounts_url}#{user_id}", base_options).body
      JSON.parse response
    end

    def self.destroy_custom_data(user_id)
      response = delete(
        canvas_custom_data_url(user_id) + "?ns=#{ENV['CANVAS_NAMESPACE']}",
        base_options,
      ).body
      JSON.parse response
    end

    def self.enrollments(user_id)
      response = get(enrollments_url(user_id), base_options).body
      JSON.parse response
    end

    def self.canvas_accounts_url
      "/accounts/#{ENV['CANVAS_ACCOUNT_ID']}/users/"
    end

    def self.canvas_user_url(user_id)
      "/users/#{user_id}"
    end

    def self.canvas_custom_data_url(user_id)
      "/users/#{user_id}/custom_data/"
    end

    def self.enrollments_url(user_id)
      "/users/#{user_id}/enrollments"
    end
  end
end
